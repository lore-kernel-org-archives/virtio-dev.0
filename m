Return-Path: virtio-dev-return-2381-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A32E5818E57
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Jul 2017 06:03:18 -0700 (PDT)
Message-ID: <59661EA2.2040708@intel.com>
Date: Wed, 12 Jul 2017 21:05:38 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com> <1497004901-30593-4-git-send-email-wei.w.wang@intel.com> <20170613200049-mutt-send-email-mst@kernel.org> <594240E9.2070705@intel.com> <20170628150450.GA1402@bombadil.infradead.org>
In-Reply-To: <20170628150450.GA1402@bombadil.infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH v11 3/6] virtio-balloon: VIRTIO_BALLOON_F_PAGE_CHUNKS
To: Matthew Wilcox <willy@infradead.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Matthew,

On 06/28/2017 11:04 PM, Matthew Wilcox wrote:
> On Thu, Jun 15, 2017 at 04:10:17PM +0800, Wei Wang wrote:
>>> So you still have a home-grown bitmap. I'd like to know why
>>> isn't xbitmap suggested for this purpose by Matthew Wilcox
>>> appropriate. Please add a comment explaining the requirements
>>> from the data structure.
>> I didn't find his xbitmap being upstreamed, did you?
> It doesn't have any users in the tree yet.  Can't add code with new users.
> You should be the first!

Glad to be the first person eating your tomato. Taste good :-)
Please have a check how it's cooked in the latest v12 patches. Thanks.

Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

