Return-Path: virtio-dev-return-2616-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C33D85818F38
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Oct 2017 01:05:06 -0700 (PDT)
Message-ID: <59E85D2A.1060407@intel.com>
Date: Thu, 19 Oct 2017 16:07:06 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1506744354-20979-1-git-send-email-wei.w.wang@intel.com> <1506744354-20979-6-git-send-email-wei.w.wang@intel.com> <20171001060305-mutt-send-email-mst@kernel.org> <286AC319A985734F985F78AFA26841F73932025A@shsmsx102.ccr.corp.intel.com> <20171010180636-mutt-send-email-mst@kernel.org> <59DDB428.4020208@intel.com> <20171011161912-mutt-send-email-mst@kernel.org> <59DEE790.5040809@intel.com> <20171013163503-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171013163503-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v16 5/5] virtio-balloon: VIRTIO_BALLOON_F_CTRL_VQ
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "willy@infradead.org" <willy@infradead.org>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 10/13/2017 09:38 PM, Michael S. Tsirkin wrote:
> On Thu, Oct 12, 2017 at 11:54:56AM +0800, Wei Wang wrote:
>>> But I think flushing is very fragile. You will easily run into races
>>> if one of the actors gets out of sync and keeps adding data.
>>> I think adding an ID in the free vq stream is a more robust
>>> approach.
>>>
>> Adding ID to the free vq would need the device to distinguish whether it
>> receives an ID or a free page hint,
> Not really.  It's pretty simple: a 64 bit buffer is an ID. A 4K and bigger one
> is a page.

I think we can also use the previous method, free page via in_buf, and 
id via out_buf.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

