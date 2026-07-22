export interface ArticleLayout {
  images: string[];
  layout: string;
  titlePos?: string;
}

export const articleLayouts: Record<string, ArticleLayout> = {
  "01-cities-that-never-sleep": {
    images: ["/images/image3.jpg", "/images/image1.jpg", "/images/image4.jpg", "/images/image2.jpg"],
    layout: "mainleft",
  },
  "02-three-ways-to-disappear": {
    images: ["/images/image2.jpg", "/images/image4.jpg", "/images/image1.jpg", "/images/image3.jpg"],
    layout: "dupeshift",
  },
  "03-the-last-payphone": {
    images: ["/images/image3.jpg", "/images/image1.jpg", "/images/image4.jpg", "/images/image2.jpg"],
    layout: "hsplit",
    titlePos: "bottomright",
  },
  "04-small-grid-theory": {
    images: ["/images/image4.jpg", "/images/image1.jpg", "/images/image2.jpg", "/images/image3.jpg"],
    layout: "cornerpull",
  },
  "05-the-maintenance-workers": {
    images: ["/images/image2.jpg", "/images/image4.jpg"],
    layout: "vstack",
    titlePos: "bottomright",
  },
  "06-the-signal-layer": {
    images: ["/images/image1.jpg", "/images/image3.jpg", "/images/image4.jpg", "/images/image2.jpg"],
    layout: "dupetriple",
  },
};
