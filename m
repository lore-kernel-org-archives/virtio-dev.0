Return-Path: <quic_svaddagi@quicinc.com>
Date: Mon, 16 Aug 2021 19:04:51 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Subject: Re: [virtio-dev] Re: [PATCH v1] virtio-mmio: Specify wait needed in
 driver during reset
Message-ID: <20210816133451.GA8203@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <87eebl5msn.fsf@redhat.com>
 <20210726091851-mutt-send-email-mst@kernel.org>
 <BY5PR02MB7073036306A91FEF52CCC5FBF9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <20210726141737-mutt-send-email-mst@kernel.org>
 <09b74816-8a1e-f993-640f-eb790a4a4698@redhat.com>
 <20210811100550.GC21582@quicinc.com>
 <2723b42a-f5d0-9c49-bf5c-302fbd4c947f@redhat.com>
 <20210816013138-mutt-send-email-mst@kernel.org>
 <20210816063550.GD5604@quicinc.com>
 <20210816074558-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210816074558-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok
 Soni <quic_tsoni@quicinc.com>, Pratik Patel <quic_pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

* Michael S. Tsirkin <mst@redhat.com> [2021-08-16 07:48:56]:

> On Mon, Aug 16, 2021 at 12:05:50PM +0530, Srivatsa Vaddagiri wrote:
> > * Michael S. Tsirkin <mst@redhat.com> [2021-08-16 01:35:46]:
> > 
> > > So thinking about all this, quite early in the setup process we
> > > have:
> > > 
> > >         /* Figure out what features the device supports. */
> > >         device_features = dev->config->get_features(dev);
> > > 
> > > 
> > > isn't this sufficient? this will flush out
> > > all writes and device can defer responding to reads
> > > until reset is complete.
> > 
> > Hmm not sure if that's possible in all MMIO devices? I think a while back Jason
> > felt some of the MMIO devices, their registers could act as plain DRAM for
> > reads, which means device can't block such reads?
> > 
> > - vatsa
> 
> Is it worth bothering about theoretical issues though? Jason what is
> your take?

What about the case where device reset fails, which may require driver to
initiate reset again or give up on device? Won't the read of features be forever
deferred in that case?

- vatsa

---
 
Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
non-member to the virtio-dev mailing list for consideration and inclusion.

