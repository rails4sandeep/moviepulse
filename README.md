moviepulse
==========

This is the source code that powers the ww.moviepulse.info webapp.

A user centric movie rating site that provides users information about watching trends of the movies.

/* Sticky footer styles
-------------------------------------------------- */

         html,
         body {
           height: 100%;
           /* The html and body elements cannot have any padding or margin. */
         }

         /* Wrapper for page content to push down footer */
         #wrap {
           min-height: 100%;
           height: auto !important;
           height: 100%;
           /* Negative indent footer by it's height */
           margin: 0 auto -60px;
         }

         /* Set the fixed height of the footer here */
         #push,
         #footer {
           height: 60px;
         }

         #footer {
           background-color: #DD4814;
         }

         /* Lastly, apply responsive CSS fixes as necessary */
         @media (max-width: 767px) {
           #footer {
             margin-left: -20px;
             margin-right: -20px;
             padding-left: 20px;
             padding-right: 20px;
           }
         }

         /* Custom page CSS
-------------------------------------------------- */
      /* Not required for template or sticky footer method. */

      .container {
        width: auto;
        max-width: 680px;
      }
      .container .credit {
        margin: 20px 0;
      }
