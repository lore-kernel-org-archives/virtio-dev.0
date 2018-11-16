Return-Path: virtio-dev-return-4973-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C03DD985EB7
	for <virtio-dev@lists.oasis-open.org>; Fri, 16 Nov 2018 01:33:51 +0000 (UTC)
Message-ID: <5BEE1FA0.10002@intel.com>
Date: Fri, 16 Nov 2018 09:38:40 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <154230782139.21.15647395935691674416@c26723477dc9>
In-Reply-To: <154230782139.21.15647395935691674416@c26723477dc9>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH v9 0/8] virtio-balloon: free page hint support
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, liliang.opensource@gmail.com, peterx@redhat.com, pbonzini@redhat.com, nilal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 11/16/2018 02:50 AM, no-reply@patchew.org wrote:
> Hi,
>
> This series failed docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
>
>    CC      net/filter.o
>    CC      net/filter-buffer.o
>    CC      net/filter-mirror.o
>    CC      net/colo-compare.o
> /tmp/qemu-test/src/migration/rdma.c: In function 'qemu_rdma_accept':
> /tmp/qemu-test/src/migration/rdma.c:3353:5: error: implicit declaration of function 'migrate_postcopy' [-Werror=implicit-function-declaration]
>       if (migrate_postcopy() && !rdma->is_return_path) {
>       ^
> /tmp/qemu-test/src/migration/rdma.c:3353:5: error: nested extern declaration of 'migrate_postcopy' [-Werror=nested-externs]
> cc1: all warnings being treated as errors
> make: *** [migration/rdma.o] Error 1
> make: *** Waiting for unfinished jobs....

This is caused by missing "migration/misc.h" in rdma.c, since we moved 
the migrate_postcopy() declaration there. I'll add it.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

