Return-Path: virtio-dev-return-7486-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 74E79985F63
	for <virtio-dev@lists.oasis-open.org>; Thu, 18 Jun 2020 17:21:05 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
References: <20200527041212.12700.60627.stgit@localhost.localdomain>
 <20200527041414.12700.50293.stgit@localhost.localdomain>
 <CAKgT0UdPC1s0c-wqsNc4x8DeZhtZQVMmLArWQ=Z345Mkof650Q@mail.gmail.com>
 <4f37c184-cf62-5711-a737-925533b52d73@redhat.com>
 <CAKgT0Udmxjx66hEhDyqWS1wBkAfEf_hht8FZAOuh3NMDOAOR3w@mail.gmail.com>
 <aea3b6e6-f653-dd0c-5e17-d0c948a6af4b@redhat.com>
 <20200618120121-mutt-send-email-mst@kernel.org>
 <1ee4f06d-f0bb-4155-ee82-1d56c346e2a0@redhat.com>
Message-ID: <6a91f543-4d63-4d98-69e0-2613e72813f6@redhat.com>
Date: Thu, 18 Jun 2020 19:20:54 +0200
MIME-Version: 1.0
In-Reply-To: <1ee4f06d-f0bb-4155-ee82-1d56c346e2a0@redhat.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

 > There are other concerns I had regarding the iothread (e.g., while
> reporting is active, virtio_ballloon_get_free_page_hints() is
> essentially a busy loop, in contrast to documented -
> continue_to_get_hints will always be true).

FWIW, I just double checked this and my memory was bad.

 -
-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

