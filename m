Return-Path: <mst@redhat.com>
Date: Thu, 9 Feb 2023 08:22:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] [PATCH] audio->sound
Message-ID: <20230209082219-mutt-send-email-mst@kernel.org>
References: <20220908083044.95376-1-mst@redhat.com>
 <87sfl2s01f.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87sfl2s01f.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 08, 2022 at 11:11:40AM +0200, Cornelia Huck wrote:
> On Thu, Sep 08 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Spec calls the device "sound device". Make the name in the
> > ID section match.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  content.tex | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/content.tex b/content.tex
> > index 5c66e6b..279998a 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -3014,7 +3014,7 @@ \chapter{Device Types}\label{sec:Device Types}
> >  \hline
> >  24         &   Memory device \\
> >  \hline
> > -25         &   Audio device \\
> > +25         &   Sound device \\
> >  \hline
> >  26         &   file system device \\
> >  \hline
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 
> Actually, under the title "Sound device", the spec says
> 
> "The virtio sound card is a virtual audio device..."
> 
> -- should it be "virtio sound device" instead?

This card/device thing is something Parav is interested in ;)
/me hides

-- 
MST

