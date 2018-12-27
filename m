Return-Path: virtio-dev-return-5205-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4E76E985E2B
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Dec 2018 11:31:23 +0000 (UTC)
References: <1535333539-32420-1-git-send-email-wei.w.wang@intel.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 27 Dec 2018 12:31:11 +0100
In-Reply-To: <1535333539-32420-1-git-send-email-wei.w.wang@intel.com>
Content-Language: en-US
Message-Id: <0661b05a-d9d0-d374-44e8-2583463e94c2@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v37 0/3] Virtio-balloon: support free page reporting
To: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, dgilbert@redhat.com
Cc: torvalds@linux-foundation.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, peterx@redhat.com, quintela@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch triggers random crashes in the guest kernel on s390 early during=
 boot.
No migration and no setting of the balloon is involved.




On 27.08.2018 03:32, Wei Wang wrote:
> The new feature, VIRTIO_BALLOON_F_FREE_PAGE_HINT, implemented by this
> series enables the virtio-balloon driver to report hints of guest free
> pages to host. It can be used to accelerate virtual machine (VM) live
> migration. Here is an introduction of this usage:
>=20
> Live migration needs to transfer the VM's memory from the source machine
> to the destination round by round. For the 1st round, all the VM's memory
> is transferred. From the 2nd round, only the pieces of memory that were
> written by the guest (after the 1st round) are transferred. One method
> that is popularly used by the hypervisor to track which part of memory is
> written is to have the hypervisor write-protect all the guest memory.
>=20
> This feature enables the optimization by skipping the transfer of guest
> free pages during VM live migration. It is not concerned that the memory
> pages are used after they are given to the hypervisor as a hint of the
> free pages, because they will be tracked by the hypervisor and transferred
> in the subsequent round if they are used and written.
>=20
> * Tests
> 1 Test Environment
>     Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
>     Migration setup: migrate_set_speed 100G, migrate_set_downtime 400ms
>=20
> 2 Test Results (results are averaged over several repeated runs)
>     2.1 Guest setup: 8G RAM, 4 vCPU
>         2.1.1 Idle guest live migration time
>             Optimization v.s. Legacy =3D 620ms vs 2970ms
>             --> ~79% reduction
>         2.1.2 Guest live migration with Linux compilation workload
>           (i.e. make bzImage -j4) running
>           1) Live Migration Time:
>              Optimization v.s. Legacy =3D 2273ms v.s. 4502ms
>              --> ~50% reduction
>           2) Linux Compilation Time:
>              Optimization v.s. Legacy =3D 8min42s v.s. 8min43s
>              --> no obvious difference
>=20
>     2.2 Guest setup: 128G RAM, 4 vCPU
>         2.2.1 Idle guest live migration time
>             Optimization v.s. Legacy =3D 5294ms vs 41651ms
>             --> ~87% reduction
>         2.2.2 Guest live migration with Linux compilation workload
>           1) Live Migration Time:
>             Optimization v.s. Legacy =3D 8816ms v.s. 54201ms
>             --> 84% reduction
>           2) Linux Compilation Time:
>              Optimization v.s. Legacy =3D 8min30s v.s. 8min36s
>              --> no obvious difference
>=20
> ChangeLog:
> v36->v37:
>     - free the reported pages to mm when receives a DONE cmd from host.
>       Please see patch 1's commit log for reasons. Please see patch 1's
>       commit for detailed explanations.
>=20
> For ChangeLogs from v22 to v36, please reference
> https://lkml.org/lkml/2018/7/20/199
>=20
> For ChangeLogs before v21, please reference
> https://lwn.net/Articles/743660/
>=20
> Wei Wang (3):
>   virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
>   mm/page_poison: expose page_poisoning_enabled to kernel modules
>   virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON
>=20
>  drivers/virtio/virtio_balloon.c     | 374 ++++++++++++++++++++++++++++++=
++----
>  include/uapi/linux/virtio_balloon.h |   8 +
>  mm/page_poison.c                    |   6 +
>  3 files changed, 355 insertions(+), 33 deletions(-)
>=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

