Return-Path: virtio-dev-return-4353-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E383258191DE
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Jun 2018 04:47:35 -0700 (PDT)
Date: Tue, 12 Jun 2018 14:47:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180612143554-mutt-send-email-mst@kernel.org>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
 <fcefe501-b410-f1ec-829c-68199edcdbef@intel.com>
 <20180605152344-mutt-send-email-mst@kernel.org>
 <CADGSJ21Qf6KpLzr+og5DOFjMPqu69n6dWRLvvj1FGAR5kVRNew@mail.gmail.com>
 <20180606002650-mutt-send-email-mst@kernel.org>
 <CADGSJ21AMp02vV+qxa+DuyvAUCCsXUFwV7wjzQ1Vy1jKV=n1HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGSJ21AMp02vV+qxa+DuyvAUCCsXUFwV7wjzQ1Vy1jKV=n1HA@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH] qemu: Introduce VIRTIO_NET_F_STANDBY
 feature bit to virtio_net
To: Siwei Liu <loseweigh@gmail.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jun 05, 2018 at 03:09:26PM -0700, Siwei Liu wrote:
> The thing is cloud service provider might prefer sticking to the same
> level of service agreement (SLA) of keeping VF over migration,

That requirement is trivially satisfied by just a single VF :) If your
SLA does not require live migration, you should do just that.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

