Return-Path: virtio-dev-return-2731-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 10A815818FE7
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Dec 2017 00:04:13 -0800 (PST)
Message-ID: <5A210D6D.3090402@intel.com>
Date: Fri, 01 Dec 2017 16:06:05 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com> <1511963726-34070-7-git-send-email-wei.w.wang@intel.com> <20171130213231-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171130213231-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v18 06/10] virtio_ring: add a new API, virtqueue_add_one_desc
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/01/2017 03:38 AM, Michael S. Tsirkin wrote:
> On Wed, Nov 29, 2017 at 09:55:22PM +0800, Wei Wang wrote:
>> Current virtqueue_add API implementation is based on the scatterlist
>> struct, which uses kaddr. This is inadequate to all the use case of
>> vring. For example:
>> - Some usages don't use IOMMU, in this case the user can directly pass
>>    in a physical address in hand, instead of going through the sg
>>    implementation (e.g. the VIRTIO_BALLOON_F_SG feature)
>> - Sometimes, a guest physical page may not have a kaddr (e.g. high
>>    memory) but need to use vring (e.g. the VIRTIO_BALLOON_F_FREE_PAGE_VQ
>>    feature)
>>
>> The new API virtqueue_add_one_desc enables the caller to assign a vring
>> desc with a physical address and len. Also, factor out the common code
>> with virtqueue_add in vring_set_avail.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
> You previously managed without this patch, and it's preferable
> IMHO since this patchset is already too big.
>
> I don't really understand what is wrong with virtio_add_sgs + sg_set_page.
> I don't think is assumes a kaddr.
>

OK, I will use the previous method to send sgs.
Please have a check if there are other things need to be improved.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

