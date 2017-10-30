Return-Path: virtio-dev-return-2638-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id EE01A1CB80B6
	for <virtio-dev@lists.oasis-open.org>; Mon, 30 Oct 2017 09:40:14 -0700 (PDT)
Date: Mon, 30 Oct 2017 18:40:12 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171030183541-mutt-send-email-mst@kernel.org>
References: <ad5f63b4-e576-3778-9080-4c4e3e5710cb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad5f63b4-e576-3778-9080-4c4e3e5710cb@arm.com>
Subject: [virtio-dev] Re: Status of virtio-iommu
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Oct 30, 2017 at 11:31:06AM +0000, Jean-Philippe Brucker wrote:
> Hi Michael,
> 
> Sorry you couldn't make it to the KVM forum, I hope everything is fine on
> your side. The virtio discussions were interesting, and I'm still trying
> to wrap my head around the packed ring layout.
> 
> >From a few conversations I had in Prague and in private, it seems like
> many companies are interested in virtio-iommu. So I think the next step is
> to try to upstream the Linux driver (I will send the patch shortly),
> followed by Qemu device.
> 
> Afterwards we'll analyze performance and try various optimizations, since
> both device and driver are very simplistic and suboptimal at the moment.
> I'd like to start this optimization work after upstreaming device and
> driver, so it's easier to review and people can reproduce our benchmark
> results. Then I'd also like to study some ideas that should drastically
> improve interaction with virtio/vhost-based endpoints, which could be the
> subject of another publication and talk.
> 
> The code and specification is being reviewed by people specializing in Arm
> and x86 IOMMUs, but unfortunately not many specializing in virtio. Eric
> Auger and others are planning to review the Linux driver.
> 
> In order to upstream the driver, I'd like to request a virtio device ID,
> but can't figure out what the correct route is. I was planning to send a
> specification patch to the virtio-dev mailing list, but should I first
> fill a ticket on issues.oasis-open.org?
> 
> Thanks,
> Jean

Actually I am working on documenting the process.

-----

What is the process the make small changes to the spec?

git clone https://github.com/oasis-tcs/virtio-spec
edit spec
sh makeall.sh

Make sure you get a working pdf. Requires xelatex.
Recommended distribution: tex live.

Right now builds on linux. Patches for other OS-es welcome.

Subscribe to the comment list by sending a blank email message to: virtio-comment-subscribe@lists.oasis-open.org

Confirm your subscription request by replying to the confirmation email message
you will receive from OASIS. Your subscription will not be complete until you
respond to this message.

Watch your inbox for a Welcome message indicating that your subscription is now active.

Send your patch to: virtio-comment@lists.oasis-open.org

Wait up to 1 week for possible comments, and reply as appropriate.

Send email to the mailing list, and copy the chair (mst@redhat.com)
asking for a ballot to approve the change.
Ballot runs for 1 week.

Patch will be merged in a couple of days after that.

-----

Adding an issue saves me work, if you can do it and list issue
number in the commit log, that's great.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

