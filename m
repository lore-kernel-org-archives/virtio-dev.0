Return-Path: <quic_svaddagi@quicinc.com>
Date: Tue, 17 Aug 2021 18:18:11 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Subject: Re: [virtio-dev] Re: [PATCH v1] virtio-mmio: Specify wait needed in
 driver during reset
Message-ID: <20210817124811.GB9207@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20210726141737-mutt-send-email-mst@kernel.org>
 <09b74816-8a1e-f993-640f-eb790a4a4698@redhat.com>
 <20210811100550.GC21582@quicinc.com>
 <2723b42a-f5d0-9c49-bf5c-302fbd4c947f@redhat.com>
 <20210816013138-mutt-send-email-mst@kernel.org>
 <20210816063550.GD5604@quicinc.com>
 <20210816074558-mutt-send-email-mst@kernel.org>
 <af73ed7b-b339-3ba2-87cb-176a9435fa2c@redhat.com>
 <20210817034312-mutt-send-email-mst@kernel.org>
 <20210817100333.GA9207@quicinc.com>
MIME-Version: 1.0
In-Reply-To: <20210817100333.GA9207@quicinc.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok
 Soni <quic_tsoni@quicinc.com>, Pratik Patel <quic_pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

* Srivatsa Vaddagiri <quic_svaddagi@quicinc.com> [2021-08-17 15:33:33]:

> Handling reset is the only open issue we have, as guest triggering reset has
> currently no provision to poll for reset completion and hypervisor itself cannot
> handle reset completly. This is where we observed discrepancy between PCI vs
> MMIO in handling reset, which we wanted to address with this discussion.
> 
> I think the option we discussed earlier of a new feature bit seems less
> intrusive than incrementing MMIO version?
> 
> https://lists.oasis-open.org/archives/virtio-dev/202107/msg00168.html

Alternately would it be fine to merge a change like this to Linux virtio_mmio
driver w/o requiring any further changes to spec?

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 56128b9..9db81e6 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -262,6 +262,9 @@ static void vm_reset(struct virtio_device *vdev)
 
 	/* 0 status means a reset. */
 	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
+
+	while (vm_get_status(vdev))
+		msleep(1);
 }
 
 

-- 
Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
non-member to the virtio-dev mailing list for consideration and inclusion.

