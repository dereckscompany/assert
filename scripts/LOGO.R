#!/usr/bin/env Rscript
# ============================================================================
# LOGO.R - Generate the assert hex sticker
# ============================================================================
# Multi-layer compositing: ggplot2 renders layers, magick applies a real
# gaussian-blur glow via screen blending.
#
# Concept: a bold checkmark -- the universal "valid / passed / asserted true"
# mark -- glowing inside a hexagon. A thin inner hex "gate" ring frames it,
# evoking the package's job of guarding what passes into your functions.
# Dark slate field, confident green check, soft glow. The "assert" wordmark
# sits below.
#
# Usage:  Rscript scripts/LOGO.R
# Deps:   ggplot2, magick
# ============================================================================

library(ggplot2)
library(magick)

# ============================================================================
# Palette
# ============================================================================

col_hex_fill <- "#0E1320" # deep slate field
col_hex_edge <- "#2BD46A" # green hex border
col_gate_ring <- "#1E2A3A" # subtle concentric "gate" rings
col_central <- "#243650" # central solid hexagon (lightest slate)
col_check <- "#2BD46A" # the checkmark — valid green
col_check_core <- "#9CF7C2" # bright inner highlight of the check
col_glow <- "#2BD46A" # glow source colour
col_wordmark <- "#F0F4F8" # near-white wordmark

# ============================================================================
# Geometry helpers
# ============================================================================

# Pointy-top hexagon vertices (vertex at the top), radius r, centred at (cx, cy).
hex_vertices <- function(cx = 0, cy = 0, r = 1) {
  angles <- seq(pi / 2, pi / 2 + 2 * pi, length.out = 7)[1:6]
  return(data.frame(x = cx + r * cos(angles), y = cy + r * sin(angles)))
}

# The three points of the checkmark stroke (short arm then long arm).
# Sized and nudged up to sit comfortably inside the hexagon, leaving room
# for the wordmark below.
check_path <- function() {
  return(data.frame(
    x = c(-0.24, -0.056, 0.274),
    y = c(0.031, -0.171, 0.280)
  ))
}

logo_theme <- function() {
  return(
    theme_void() +
      theme(
        plot.background = element_rect(fill = "transparent", colour = NA),
        panel.background = element_rect(fill = "transparent", colour = NA),
        plot.margin = margin(0, 0, 0, 0)
      )
  )
}

logo_coord <- function() {
  return(coord_equal(xlim = c(-0.67, 0.67), ylim = c(-0.67, 0.67)))
}

# Render a ggplot to a magick image on a transparent background.
render_layer <- function(p, width = 3000, height = 3480) {
  tmp <- tempfile(fileext = ".png")
  ggsave(tmp, plot = p, width = width / 600, height = height / 600, dpi = 600, bg = "transparent")
  img <- image_read(tmp)
  unlink(tmp)
  return(img)
}

# ============================================================================
# Layers
# ============================================================================

# Base: hex field, border, inner gate ring, the checkmark, and the wordmark.
build_base_layer <- function() {
  hex_outer <- hex_vertices(0, 0, 0.62)
  check <- check_path()

  # Concentric hexagon outlines stepping inward from the border.
  ring_radii <- c(0.52, 0.43, 0.34, 0.25, 0.16)
  rings <- lapply(ring_radii, function(r) {
    hv <- hex_vertices(0, 0, r)
    geom_path(data = rbind(hv, hv[1, ]), aes(x, y), colour = col_gate_ring, linewidth = 4)
  })
  # The innermost hexagon is solid.
  hex_centre <- hex_vertices(0, 0, 0.08)

  ggplot() +
    # Hex field
    geom_polygon(data = hex_outer, aes(x, y), fill = col_hex_fill, colour = col_hex_edge, linewidth = 7) +
    # Concentric "gate" rings
    rings +
    # Central solid hexagon
    geom_polygon(data = hex_centre, aes(x, y), fill = col_central, colour = NA) +
    # Checkmark — outer stroke
    geom_path(
      data = check,
      aes(x, y),
      colour = col_check,
      linewidth = 18,
      lineend = "round",
      linejoin = "round"
    ) +
    # Checkmark — bright inner highlight
    geom_path(
      data = check,
      aes(x, y),
      colour = col_check_core,
      linewidth = 6,
      lineend = "round",
      linejoin = "round"
    ) +
    # Wordmark
    annotate(
      "text",
      x = 0,
      y = -0.34,
      label = "assert",
      colour = col_wordmark,
      size = 15,
      fontface = "bold",
      family = "sans"
    ) +
    logo_coord() +
    logo_theme()
}

# Glow source: just the checkmark, fat and bright, to be blurred.
build_glow_layer <- function() {
  check <- check_path()
  ggplot() +
    geom_path(
      data = check,
      aes(x, y),
      colour = col_glow,
      linewidth = 21,
      lineend = "round",
      linejoin = "round"
    ) +
    logo_coord() +
    logo_theme()
}

# ============================================================================
# Composite
# ============================================================================

generate_logo <- function(
  output_path = file.path("man", "figures", "logo.png"),
  px_width = 3000,
  px_height = 3480
) {
  message("Rendering base layer...")
  base_img <- render_layer(build_base_layer(), px_width, px_height)

  message("Rendering glow layer...")
  glow_img <- render_layer(build_glow_layer(), px_width, px_height)

  message("Blurring glow...")
  glow_wide <- image_blur(glow_img, radius = 0, sigma = 45)
  glow_tight <- image_blur(glow_img, radius = 0, sigma = 15)

  message("Compositing...")
  final <- base_img |>
    image_composite(glow_wide, operator = "screen") |>
    image_composite(glow_tight, operator = "screen") |>
    image_composite(base_img, operator = "over")

  final <- image_trim(final)

  dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)
  image_write(final, output_path, format = "png")
  message("Logo saved to: ", output_path)

  for (dest in c("docs/logo.png", "docs/reference/figures/logo.png")) {
    if (dir.exists(dirname(dest))) {
      file.copy(output_path, dest, overwrite = TRUE)
      message("Copied to:    ", dest)
    }
  }

  return(invisible(final))
}

# ============================================================================
# Run
# ============================================================================

if (!interactive() || identical(Sys.getenv("LOGO_GENERATE"), "true")) {
  generate_logo()
} else {
  message("Source this file and call generate_logo() to create the sticker.")
  message("Or run: Rscript scripts/LOGO.R")
}
