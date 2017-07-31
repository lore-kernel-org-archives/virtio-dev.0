Return-Path: virtio-dev-return-2430-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 118AF5819382
	for <virtio-dev@lists.oasis-open.org>; Mon, 31 Jul 2017 15:18:41 -0700 (PDT)
Message-ID: <597F2439.5070309@intel.com>
Date: Mon, 31 Jul 2017 20:36:09 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <59686EEB.8080805@intel.com> <20170723044036-mutt-send-email-mst@kernel.org> <59781119.8010200@intel.com> <20170726155856-mutt-send-email-mst@kernel.org> <597954E3.2070801@intel.com> <20170729020231-mutt-send-email-mst@kernel.org> <597C83CC.7060702@intel.com> <20170730043922-mutt-send-email-mst@kernel.org> <286AC319A985734F985F78AFA26841F739288D85@shsmsx102.ccr.corp.intel.com> <20170730191735-mutt-send-email-mst@kernel.org> <20170730191911-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170730191911-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v12 5/8] virtio-balloon: VIRTIO_BALLOON_F_SG
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 07/31/2017 12:20 AM, Michael S. Tsirkin wrote:
> On Sun, Jul 30, 2017 at 07:18:33PM +0300, Michael S. Tsirkin wrote:
>> On Sun, Jul 30, 2017 at 05:59:17AM +0000, Wang, Wei W wrote:
>> That's a hypervisor implementation detail. From guest point of view,
>> discarding contents can not be distinguished from writing old contents.
>>
> Besides, ignoring the free page tricks, consider regular ballooning.
> We map page with DONTNEED then back with WILLNEED. Result is
> getting a zero page. So at least one of deflate/inflate should be input.
> I'd say both for symmetry.
>

OK, I see the point. Thanks.

Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

