Return-Path: <pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
References: <20211006103244.32388-1-pankaj.gupta.linux@gmail.com>
 <87fst3vaqm.fsf@redhat.com> <CAM9Jb+isBoXr2TNb9zswOeALcS4h9E-pAesD2amUdiHUibOqNg@mail.gmail.com>
 <874k9iv8v9.fsf@redhat.com>
In-Reply-To: <874k9iv8v9.fsf@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Fri, 15 Oct 2021 13:36:11 +0200
Message-ID: <CAM9Jb+hkF5Kdcj1=JiGMo9AeUQD9OxPr=ZKAuD3+x15U+hP1rA@mail.gmail.com>
Subject: Re: [PATCH v6] virtio-pmem: PMEM device spec
Content-Type: text/plain; charset="UTF-8"
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Taylor Stark <tstark@linux.microsoft.com>, Pankaj Gupta <pankaj.gupta@ionos.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Thank you!

@Taylor Stark  Since now have virtio pmem spec merged, we can propose
spec changes for "virtio-pmem: Support PCI BAR-relative addresses"
support.

Best regards,
Pankaj

On Fri, 15 Oct 2021 at 13:13, Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Fri, Oct 15 2021, Pankaj Gupta <pankaj.gupta.linux@gmail.com> wrote:
>
> >> So, I ran into some problems while trying to apply this.
> >>
> >> First, this is against an older version of the tree, so it did not apply
> >> cleanly.
> >
> > Sorry! somehow i missed this.
>
> No worries, I fixed that up; but rebasing makes things easier for the
> person applying it.
>
> >>
> >> Second, the conformance section looks off: we don't have a driver
> >> conformance section, and the device conformance section ends up being
> >> called a driver conformance section. Unfortunately, I had neglected to
> >> review that properly :(
> >>
> >> I think the following would be correct; I'm inclined to apply this spec
> >> with it as an editorial edit. Any comments/objections?
> >
> > my bad :(
> >
> > Thank you for your help!
> > Hope this makes into master now.
>
> I pushed this out now. If something is off, we can fix that on top.
>

