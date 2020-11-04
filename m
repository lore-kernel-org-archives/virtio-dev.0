Return-Path: virtio-dev-return-7839-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D4D4985E6F
	for <virtio-dev@lists.oasis-open.org>; Wed,  4 Nov 2020 09:33:51 +0000 (UTC)
Date: Wed, 4 Nov 2020 10:33:28 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <20201104093328.GA505400@myrica>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
 <d54b674e-2626-fc73-d663-136573c32b8a@redhat.com>
 <20201002182348.GO138842@redhat.com>
 <e8a37837-30d0-d7cc-496a-df4c12fff1da@redhat.com>
 <20201103200904.GA1557194@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103200904.GA1557194@redhat.com>
Subject: [virtio-dev] Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Al Stone <ahs3@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org, bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Al,

On Tue, Nov 03, 2020 at 01:09:04PM -0700, Al Stone wrote:
> So, there are some questions about the VIOT definition and I just
> don't know enough to be able to answer them.  One of the ASWG members
> is trying to understand the semantics behind the subtables.

Thanks for the update. We dropped subtables a few versions ago, though, do
you have the latest v8?
https://jpbrucker.net/virtio-iommu/viot/viot-v8.pdf

> Is there a particular set of people, or mailing lists, that I can
> point to to get the questions answered?  Ideally it would be one
> of the public lists where it has already been discussed, but an
> individual would be fine, too.  No changes have been proposed, just
> some questions asked.

For a public list, I suggest iommu@lists.linux-foundation.org if we should
pick only one (otherwise add virtualization@lists.linux-foundation.org and
virtio-dev@lists.oasis-open.org). I'm happy to answer any question, and
the folks on here are a good set to Cc:

eric.auger@redhat.com
jean-philippe@linaro.org
joro@8bytes.org
kevin.tian@intel.com
lorenzo.pieralisi@arm.com
mst@redhat.com
sebastien.boeuf@intel.com

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

