Return-Path: <quic_svaddagi@quicinc.com>
Date: Wed, 18 Aug 2021 11:43:05 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Subject: Re: [virtio-dev] Re: [PATCH v1] virtio-mmio: Specify wait needed in
 driver during reset
Message-ID: <20210818061305.GE9207@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20210816063550.GD5604@quicinc.com>
 <20210816074558-mutt-send-email-mst@kernel.org>
 <af73ed7b-b339-3ba2-87cb-176a9435fa2c@redhat.com>
 <20210817034312-mutt-send-email-mst@kernel.org>
 <20210817100333.GA9207@quicinc.com>
 <e07fd648-9044-d486-29b6-83ee64b6842a@redhat.com>
 <20210818051544.GC9207@quicinc.com>
 <CACGkMEv11s=9z4gMKo_BcmVpoznEbaEOctDvp=NUK7UtrhgjjQ@mail.gmail.com>
 <20210818055102.GD9207@quicinc.com>
 <CACGkMEtu+FRv_kPKqnzFhQybrt9fVy8QROLuv8Z5i3KyL8GWOg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtu+FRv_kPKqnzFhQybrt9fVy8QROLuv8Z5i3KyL8GWOg@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok
 Soni <quic_tsoni@quicinc.com>, Pratik Patel <quic_pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

* Jason Wang <jasowang@redhat.com> [2021-08-18 14:04:04]:

> > Fine let me take a stab at the next version which will have this:
> >
> > * Introduce a status bit for device to indicate "reset in progress". This could
> >   be adopted by other transports also (for ex PCI).
> 
> I may miss something discussion but any reason that the current
> VIRTIO_MMIO_STATUS is not sufficient?

I think Mike suggested we specify what device would return while reset is in
progress, rather than any arbitrary non-zero value:

https://lists.oasis-open.org/archives/virtio-dev/202108/msg00070.html

> > * For v3 MMIO devices, driver, after initiating reset, should wait until
> >   status = 0 or device indicates "failure". What the driver does when it sees
> >   failure can be implementation defined (it can give up or try reset few more
> >   times)
> 
> Yes, but let's wait a little bit to see if it is agreed by others.

Sure. 

Mike,
	Do you suggest we add this as well for v3 device?

"after writing 0 to Status and before reading any fields, the driver
MUST read Status and wait for a read to return 0 or indicate failure"

- vatsa

-- 
Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
non-member to the virtio-dev mailing list for consideration and inclusion.

