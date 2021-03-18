Return-Path: virtio-return-3536-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 18 Mar 2021 14:23:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20210318141353-mutt-send-email-mst@kernel.org>
References: <20210316211311.154117-1-mst@redhat.com>
 <20210317094334.38116d2d.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210317094334.38116d2d.cohuck@redhat.com>
Subject: Re: [virtio] [PATCH] introduction: document #define syntax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 17, 2021 at 09:43:34AM +0100, Cornelia Huck wrote:
> On Tue, 16 Mar 2021 17:13:17 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > We use the C #define syntax to refer to numeric values.
> > Let's document that.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

thanks for the comments, tried to clarify in v2.

> > ---
> >  introduction.tex | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/introduction.tex b/introduction.tex
> > index cc38e29..4febed2 100644
> > --- a/introduction.tex
> > +++ b/introduction.tex
> > @@ -210,6 +210,27 @@ \section{Structure Specifications}
> >  \begin{lstlisting}
> >  CPU_TO_BE16(B << 15 | A)
> >  \end{lstlisting}
> > +\section{Constant Specifications}
> > +
> > +In many cases, numberic values used in the interface between the device
> 
> s/numberic/numeric/
> 
> > +and the driver are documented using the C #define and /* */
> > +comment syntax. Multiple related values are grouped together with
> > +a common name as a prefix, using _ as a separator.
> > +Using _XXX as a suffix refers to all values in a group.
> > +For example:
> > +
> > +\begin{lstlisting}
> > +/* Value A description */
> > +#define VIRTIO_VALUE_A        (1 << 0)
> > +/* Value B description */
> > +#define VIRTIO_VALUE_B        (1 << 1)
> > +\end{lstlisting}
> > +documents two numeric values: 1 meaning Value A and 2 meaning
> > +Value B.  
> 
> Doesn't that really document that Value A *is* 1? I'm a bit confused by
> that sentence.

The interface only includes numeric values. The numbers are
interpreted by the devices and the drivers to refer
to e.g. A or B.

> > Note that $<<$ refers to the shift-left operation.
> > +
> > +Further, in this case VIRTIO_VALUE_A and VIRTIO_VALUE_B
> > +refer to 1 and 2 respectively. Further, VIRTIO_VALUE_XXX refers to
> > +either VIRTIO_VALUE_A or VIRTIO_VALUE_B.
> >  
> >  \newpage
> >  


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

