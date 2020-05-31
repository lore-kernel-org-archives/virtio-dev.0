Return-Path: virtio-dev-return-7430-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C863B98423D
	for <virtio-dev@lists.oasis-open.org>; Sun, 31 May 2020 09:15:37 +0000 (UTC)
Date: Sun, 31 May 2020 05:15:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200531051357-mutt-send-email-mst@kernel.org>
References: <20200508173732.17877.85060.stgit@localhost.localdomain>
 <CAKgT0Uce78v1tA6=KHuLNx7pTX324rokprNs32dE2UtsxWnXUg@mail.gmail.com>
 <CAKgT0UeGgeAExQRGsnJ0qmK_wqosdrmqUmYVtCw4aeSQ3APffg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeGgeAExQRGsnJ0qmK_wqosdrmqUmYVtCw4aeSQ3APffg@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2 resubmit] virtio-balloon: Disable free page reporting
 if page poison reporting is not enabled
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, David Hildenbrand <david@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

Oh. A mail misconfig on my part caused me to miss this. Sorry.
Unfortunately it means it will miss 5.7.
I'll queue this and CC stable. Thanks!

On Tue, May 26, 2020 at 08:13:08AM -0700, Alexander Duyck wrote:
> Do I need to resubmit this patch? It has been over two weeks now since
> it was originally submitted, and a week and a half since I last sent
> out an email following up. I'm just wondering if there is some list I
> missed as I am assuming the maintainers and lists I contacted here are
> correct? It looks like we are at RC7 now so I am worried this won't
> make it in before LInus releases 5.7.
> 
> Thanks.
> 
> - Alex
> 
> On Fri, May 15, 2020 at 10:02 AM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> >
> > Just following up. It has been a week since I submitted this. I was
> > hoping we could get it in for 5.7 since this affects free page
> > reporting which will be introduced with that kernel release.
> >
> > Thanks.
> >
> > - Alex
> >
> > On Fri, May 8, 2020 at 10:40 AM Alexander Duyck
> > <alexander.duyck@gmail.com> wrote:
> > >
> > > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > >
> > > We should disable free page reporting if page poisoning is enabled but we
> > > cannot report it via the balloon interface. This way we can avoid the
> > > possibility of corrupting guest memory. Normally the page poisoning feature
> > > should always be present when free page reporting is enabled on the
> > > hypervisor, however this allows us to correctly handle a case of the
> > > virtio-balloon device being possibly misconfigured.
> > >
> > > Fixes: 5d757c8d518d ("virtio-balloon: add support for providing free page reports to host")
> > > Acked-by: David Hildenbrand <david@redhat.com>
> > > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > ---
> > >
> > > Changes since v1:
> > > Originally this patch also modified free page hinting, that has been removed.
> > > Updated patch title and description.
> > > Added a comment explaining reasoning for disabling free page reporting.
> > >
> > > Resbumitting v2 w/ Ack from David Hildebrand.
> > >
> > >  drivers/virtio/virtio_balloon.c |    9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > > index 51086a5afdd4..1f157d2f4952 100644
> > > --- a/drivers/virtio/virtio_balloon.c
> > > +++ b/drivers/virtio/virtio_balloon.c
> > > @@ -1107,11 +1107,18 @@ static int virtballoon_restore(struct virtio_device *vdev)
> > >
> > >  static int virtballoon_validate(struct virtio_device *vdev)
> > >  {
> > > -       /* Tell the host whether we care about poisoned pages. */
> > > +       /*
> > > +        * Inform the hypervisor that our pages are poisoned or
> > > +        * initialized. If we cannot do that then we should disable
> > > +        * page reporting as it could potentially change the contents
> > > +        * of our free pages.
> > > +        */
> > >         if (!want_init_on_free() &&
> > >             (IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY) ||
> > >              !page_poisoning_enabled()))
> > >                 __virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
> > > +       else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
> > > +               __virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
> > >
> > >         __virtio_clear_bit(vdev, VIRTIO_F_IOMMU_PLATFORM);
> > >         return 0;
> > >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

