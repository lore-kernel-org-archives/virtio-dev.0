Return-Path: <quic_svaddagi@quicinc.com>
Date: Mon, 16 Aug 2021 11:52:33 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Subject: Re: [PATCH v2] virtio-mmio: Specify wait needed in driver during
 reset
Message-ID: <20210816062233.GC5604@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20210813145351.GA5604@quicinc.com>
 <20210816010725-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210816010725-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org, tsoni@quicinc.com, pratikp@quicinc.com
List-ID: <virtio-dev.lists.oasis-open.org>

* Michael S. Tsirkin <mst@redhat.com> [2021-08-16 01:30:57]:

> > +After writing 0 to \field{Status}, which triggers a reset of device, the driver MUST wait for a read of
> > +\field{Status} to return 0 before proceeding with the remaining steps of initializing the device.
> 
> I know you copied this from pci but looking at PCI now, I think
> this is not great there either.
> 
> 1.  This is IMHO too opaque in that we did not say driver should read.
> 
> E.g. after writing 0 to Status and before reading any fields, the driver
> MUST read Status and wait for a read etc.
> 
> also would not just a read be sufficient? Is there a case for device to return any value
> other than 0 to signal "reset in progress"?

Not sure I follow you here. We need some means for device to indicate its reset
operation is complete - non-zero value of Status would indicate reset is still
in progress while zero value would indicate reset is complete? 

> 2. what if device encounters an error and sets
> NEED_RESET meanwhile? waiting for a reset will then deadlock ...
> I know, it's problematic like this in PCI too.

Hmm a reset itself having failed - not sure if another reset will clear things
up better. I guess device could attempt another reset by itself, but may give up
after couple of attempts by indicating NEED_RESET, at which point not sure if
another driver initiated reset will make a difference. At the minimum, the
guidance for drivers here would be to block until reset is completed (indicated
by Status returning 0) or device encountering some failure (NEED_RESET)? When
NEED_RESET is seen, should the spec prescribe driver to attempt reset again?

> Further what will device return after reset was written but
> before it completed? I think it is better to specify that
> rather than rely on any non-0 value meaning "wait for reset".

Yes agree, we should have a specific status bit to indicate "reset in progress"

> For pci maybe make it a SHOULD ...

Do you mean pci driver SHOULD wait until this new status bit (RESET_IN_PROGRESS)
is cleared? 

- vatsa

---
 
Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
non-member to the virtio-dev mailing list for consideration and inclusion.

