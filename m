Return-Path: virtio-dev-return-5088-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 78F95985D6D
	for <virtio-dev@lists.oasis-open.org>; Fri, 30 Nov 2018 07:04:57 +0000 (UTC)
Message-ID: <5C00E243.10409@intel.com>
Date: Fri, 30 Nov 2018 15:09:55 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com> <1542276484-25508-6-git-send-email-wei.w.wang@intel.com> <20181127073802.GC3205@xz-x1> <5BFD1BA4.5040202@intel.com> <20181128052655.GC12839@xz-x1> <5BFE596B.1080807@intel.com> <20181128093220.GF12839@xz-x1> <5BFF5FC9.2020402@intel.com> <20181129051014.GC29246@xz-x1> <5C00C52F.20606@intel.com> <20181130055736.GA15865@xz-x1>
In-Reply-To: <20181130055736.GA15865@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v9 5/8] migration/ram.c: add a notifier chain for precopy
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 11/30/2018 01:57 PM, Peter Xu wrote:
>>
>>
>> Or you can introduce migration_bitmap_sync_precopy() and let precopy
>> code call that one instead.

Agree, thanks.

> PS. I'm a bit unsure on why we need to sync bitmap in ram_init_bitmaps.
> I feel like it can be removed...

Seems it was added in early days to fix some bug:
https://git.virtualopensystems.com/dev/qemu/commit/79536f4f16934d6759a1d67f0342b4e7ceb66671?w=1

Hopefully, Juan could share some details about that.

Best,
Wei





---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

