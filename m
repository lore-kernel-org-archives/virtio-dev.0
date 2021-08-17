Return-Path: <quic_svaddagi@quicinc.com>
Date: Tue, 17 Aug 2021 15:33:33 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Subject: Re: [virtio-dev] Re: [PATCH v1] virtio-mmio: Specify wait needed in
 driver during reset
Message-ID: <20210817100333.GA9207@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <BY5PR02MB7073036306A91FEF52CCC5FBF9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <20210726141737-mutt-send-email-mst@kernel.org>
 <09b74816-8a1e-f993-640f-eb790a4a4698@redhat.com>
 <20210811100550.GC21582@quicinc.com>
 <2723b42a-f5d0-9c49-bf5c-302fbd4c947f@redhat.com>
 <20210816013138-mutt-send-email-mst@kernel.org>
 <20210816063550.GD5604@quicinc.com>
 <20210816074558-mutt-send-email-mst@kernel.org>
 <af73ed7b-b339-3ba2-87cb-176a9435fa2c@redhat.com>
 <20210817034312-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210817034312-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok
 Soni <quic_tsoni@quicinc.com>, Pratik Patel <quic_pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

* Michael S. Tsirkin <mst@redhat.com> [2021-08-17 03:51:47]:

> So before we move on I'd like to know whether we do something as drastic
> as incrementing the version number for a theoretical or practical
> benefit.

We initially stumbled on this reset issue when doing some optimization in
Qualcomm Type-1 hypervisor for virtio. In our case, virtio frontend and backend
drivers are in separate VMs. The Android VM that hosts backend driver is
considered untrusted, which among other things meant front-end could see large
latencies for its MMIO register r/w requests (largely owing to scheduling
delays). In some cases, I measured 5-10 ms for a single MMIO register read or
write request. Few of the registers are accessed in hot-path (like
VIRTIO_MMIO_QUEUE_NOTIFY or VIRTIO_MMIO_INTERRUPT_ACK) which we wanted to be of
low-latency as much as possible.

The optimization we have to help reduce this latency is for hypervisor to
acknowledge MMIO writes without waiting on backend to respond. For example, when
VM writes to VIRTIO_MMIO_QUEUE_NOTIFY, it causes a trap and normally hypervisor
would have required to stall the vcpu until backend acknowledges it. In our
case, hypervisor would unblock the vcpu immediately after injecting an interrupt
to backend (to let backend know that there is a queue_notify event). Handling
writes to VIRTIO_MMIO_INTERRUPT_ACK was bit tricky but we managed that with few
changes in backend (especially any awareness backend had about front-end being
still in a interrupt handler). Similarly other registers that are written are
completely handled in hypervisor without requiring intervention from backend.

Handling reset is the only open issue we have, as guest triggering reset has
currently no provision to poll for reset completion and hypervisor itself cannot
handle reset completly. This is where we observed discrepancy between PCI vs
MMIO in handling reset, which we wanted to address with this discussion.

I think the option we discussed earlier of a new feature bit seems less
intrusive than incrementing MMIO version?

https://lists.oasis-open.org/archives/virtio-dev/202107/msg00168.html

- vatsa

--

Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
on-member to the virtio-dev mailing list for consideration and inclusion.

