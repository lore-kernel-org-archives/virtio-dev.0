Return-Path: <quic_svaddagi@quicinc.com>
Date: Mon, 16 Aug 2021 20:28:14 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Subject: Re: [virtio-dev] Re: [PATCH v1] virtio-mmio: Specify wait needed in
 driver during reset
Message-ID: <20210816145814.GA3665@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <BY5PR02MB7073036306A91FEF52CCC5FBF9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <20210726141737-mutt-send-email-mst@kernel.org>
 <09b74816-8a1e-f993-640f-eb790a4a4698@redhat.com>
 <20210811100550.GC21582@quicinc.com>
 <2723b42a-f5d0-9c49-bf5c-302fbd4c947f@redhat.com>
 <20210816013138-mutt-send-email-mst@kernel.org>
 <20210816063550.GD5604@quicinc.com>
 <20210816074558-mutt-send-email-mst@kernel.org>
 <20210816133451.GA8203@quicinc.com>
 <20210816103348-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210816103348-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok
 Soni <quic_tsoni@quicinc.com>, Pratik Patel <quic_pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

* Michael S. Tsirkin <mst@redhat.com> [2021-08-16 10:37:18]:

> > What about the case where device reset fails, which may require driver to
> > initiate reset again or give up on device? Won't the read of features be forever
> > deferred in that case?
> > 
> > - vatsa
> 
> That might be worth addressing but I feel your proposal does not
> address it sufficiently.

Ok let me take a stab at addressing it better in my next version. Basically
here's what I am thinking. Pls let me know if there is anything else I need to
consider:

* Introduce a status bit for device to indicate "reset in progress". This could
  be adopted by other transports also (for ex PCI).

* For v3 MMIO devices, driver, after initiating reset, should wait until status = 0
  or device indicates "failure". Should the spec advise what a driver should do
  in case of failure after reset? Not sure if the outcome would be different if
  driver were to issue reset again. Again this advice should be common to both
  MMIO and PCI I think.

- vatsa

---
  
Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
non-member to the virtio-dev mailing list for consideration and inclusion.

