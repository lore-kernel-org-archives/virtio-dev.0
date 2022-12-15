Return-Path: <mst@redhat.com>
Date: Thu, 15 Dec 2022 04:27:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] content: reserve device ID 44 for ISM
 device
Message-ID: <20221215042635-mutt-send-email-mst@kernel.org>
References: <20221123112109.37560-1-xuanzhuo@linux.alibaba.com>
 <1669202497.092381-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1669202497.092381-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, cohuck@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Nov 23, 2022 at 07:21:37PM +0800, Xuan Zhuo wrote:
> On Wed, 23 Nov 2022 19:21:09 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > The virtio-ism device provides the ability to share memory between
> > different guests on a host. A guest's memory got from ism device can be
> > shared with multiple peers at the same time. This shared relationship
> > can be dynamically created and released.
> >
> > The shared memory obtained from the device is divided into multiple ism
> > regions for share. ISM device provides a mechanism to notify other ism
> > region referrers of content update events.
> 
> The last spec version:
> 
> 	https://lists.oasis-open.org/archives/virtio-dev/202211/msg00001.html
> 
> Thanks.

Hello!
Please note specification comments (including proposals) must be
posted to virtio-comments, virtio-dev is for implementation
discussions. Please post to the correct list.

Thanks!


> 
> >
> > This patch is to reserve the next available device ID for virtio-ism.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  content.tex | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/content.tex b/content.tex
> > index 91ba76c..7302365 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -2992,6 +2992,8 @@ \chapter{Device Types}\label{sec:Device Types}
> >  \hline
> >  43         &   Camera device \\
> >  \hline
> > +44         &   ISM device \\
> > +\hline
> >  \end{tabular}
> >
> >  Some of the devices above are unspecified by this document,
> > --
> > 2.32.0.3.g01195cf9f
> >
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

