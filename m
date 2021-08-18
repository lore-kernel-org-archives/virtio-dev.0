Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <2723b42a-f5d0-9c49-bf5c-302fbd4c947f@redhat.com>
 <20210816013138-mutt-send-email-mst@kernel.org> <20210816063550.GD5604@quicinc.com>
 <20210816074558-mutt-send-email-mst@kernel.org> <af73ed7b-b339-3ba2-87cb-176a9435fa2c@redhat.com>
 <20210817034312-mutt-send-email-mst@kernel.org> <20210817100333.GA9207@quicinc.com>
 <e07fd648-9044-d486-29b6-83ee64b6842a@redhat.com> <20210818051544.GC9207@quicinc.com>
 <CACGkMEv11s=9z4gMKo_BcmVpoznEbaEOctDvp=NUK7UtrhgjjQ@mail.gmail.com> <20210818055102.GD9207@quicinc.com>
In-Reply-To: <20210818055102.GD9207@quicinc.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 18 Aug 2021 14:04:04 +0800
Message-ID: <CACGkMEtu+FRv_kPKqnzFhQybrt9fVy8QROLuv8Z5i3KyL8GWOg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v1] virtio-mmio: Specify wait needed in
 driver during reset
Content-Type: text/plain; charset="UTF-8"
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok Soni <quic_tsoni@quicinc.com>, Pratik Patel <quic_pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Aug 18, 2021 at 1:51 PM Srivatsa Vaddagiri
<quic_svaddagi@quicinc.com> wrote:
>
> * Jason Wang <jasowang@redhat.com> [2021-08-18 13:40:45]:
>
> > > Hmm ..are you suggesting that we read the Version register as part of reset code
> > > and do the wait part only for v3 device?
> >
> > We only need to read the version once (see virtio_mmio_probe()). So it
>
> Ok sorry saw that now.
>
> > could be something like
> >
> > if (vm_dev->version == 0x3) {
> >     while (readl(vm_dev->base + VIRTIO_MMIO_STATUS))
> >         msleep(1);
> > }
> >
> > > Otherwise we have the same issue as
> > > feature bit with version change also.
> > >
> > > Can't the driver do the same with feature register also? Do poll if
> > > WAIT_FOR_RESET_COMPLETION feature bit is set, which can happen before feature
> > > negotiation is complete.
> >
> > The possible issue is that the feature negotiation is not done at that time.
>
> Fine let me take a stab at the next version which will have this:
>
> * Introduce a status bit for device to indicate "reset in progress". This could
>   be adopted by other transports also (for ex PCI).

I may miss something discussion but any reason that the current
VIRTIO_MMIO_STATUS is not sufficient?

>
> * For v3 MMIO devices, driver, after initiating reset, should wait until
>   status = 0 or device indicates "failure". What the driver does when it sees
>   failure can be implementation defined (it can give up or try reset few more
>   times)

Yes, but let's wait a little bit to see if it is agreed by others.

Thanks

>
> - vatsa
>
> --
> Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
> non-member to the virtio-dev mailing list for consideration and inclusion.
>

