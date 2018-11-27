Return-Path: virtio-dev-return-5044-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3EEF7985B91
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Nov 2018 10:12:16 +0000 (UTC)
Message-ID: <5BFD19A9.2010000@intel.com>
Date: Tue, 27 Nov 2018 18:17:13 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com> <1542276484-25508-4-git-send-email-wei.w.wang@intel.com> <20181127054056.GA3205@xz-x1> <5BFCDE07.20707@intel.com> <5BFCE052.8070705@intel.com> <20181127074127.GD3205@xz-x1>
In-Reply-To: <20181127074127.GD3205@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH v9 3/8] migration: use bitmap_mutex in
 migration_bitmap_clear_dirty
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 11/27/2018 03:41 PM, Peter Xu wrote:
>
> Ok then I'm fine with it.  Though you could update the comments too if
> you like:
>
>      /* protects modification of the bitmap and migration_dirty_pages */
>      QemuMutex bitmap_mutex;
>
> And it's tricky that sometimes we don't take the lock when reading
> this variable "migration_dirty_pages".  I don't see obvious issue so
> far, hope it's true (at least I skipped the colo ones...).

The caller reads the value just to estimate the remaining_size, and
it seems fine without a lock, because whether it reads a
value before the update or after the update seem not causing
an issue.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

