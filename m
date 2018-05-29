Return-Path: virtio-dev-return-4198-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 312FE58191BD
	for <virtio-dev@lists.oasis-open.org>; Tue, 29 May 2018 08:24:52 -0700 (PDT)
Date: Tue, 29 May 2018 18:24:40 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180529182411-mutt-send-email-mst@kernel.org>
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
 <7e6412ef-4f92-dafa-acaf-b61296740f3d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7e6412ef-4f92-dafa-acaf-b61296740f3d@huawei.com>
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH v7 0/5] virtio-balloon: free page hint
 reporting support
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Cc: Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, May 29, 2018 at 11:00:21PM +0800, Hailiang Zhang wrote:
> On 2018/4/24 14:13, Wei Wang wrote:
> > This is the deivce part implementation to add a new feature,
> > VIRTIO_BALLOON_F_FREE_PAGE_HINT to the virtio-balloon device. The device
> > receives the guest free page hints from the driver and clears the
> > corresponding bits in the dirty bitmap, so that those free pages are
> > not transferred by the migration thread to the destination.
> >=20
> > - Test Environment
> >      Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
> >      Guest: 8G RAM, 4 vCPU
> >      Migration setup: migrate_set_speed 100G, migrate_set_downtime 2 se=
cond
> >=20
> > - Test Results
> >      - Idle Guest Live Migration Time (results are averaged over 10 run=
s):
> >          - Optimization v.s. Legacy =3D 271ms vs 1769ms --> ~86% reduct=
ion
> >      - Guest with Linux Compilation Workload (make bzImage -j4):
> >          - Live Migration Time (average)
> >            Optimization v.s. Legacy =3D 1265ms v.s. 2634ms --> ~51% red=
uction
> >          - Linux Compilation Time
> >            Optimization v.s. Legacy =3D 4min56s v.s. 5min3s
> >            --> no obvious difference
> >=20
> > - Source Code
> >      - QEMU:  https://github.com/wei-w-wang/qemu-free-page-lm.git
> >      - Linux: https://github.com/wei-w-wang/linux-free-page-lm.git
> >=20
> > ChangeLog:
> > v6->v7:
> >        virtio-balloon/virtio_balloo_poll_free_page_hints:
> >            - add virtio_notify() at the end to notify the driver that
> >              the optimization is done, which indicates that the entries
> >              have all been put back to the vq and ready to detach them.
> > v5->v6:
> >        virtio-balloon: use iothread to get free page hint
> > v4->v5:
> >      1) migration:
> >          - bitmap_clear_dirty: update the dirty bitmap and dirty page
> >            count under the bitmap mutex as what other functions are doi=
ng;
> >          - qemu_guest_free_page_hint:
> >              - add comments for this function;
> >              - check the !block case;
> >              - check "offset > block->used_length" before proceed;
> >              - assign used_len inside the for{} body;
> >              - update the dirty bitmap and dirty page counter under the
> >                bitmap mutex;
> >          - ram_state_reset:
> >              - rs->free_page_support: && with use "migrate_postcopy"
> >                instead of migration_in_postcopy;
> >              - clear the ram_bulk_stage flag if free_page_support is tr=
ue;
> >      2) balloon:
> >           - add the usage documentation of balloon_free_page_start and
> >             balloon_free_page_stop in code;
> >           - the optimization thread is named "balloon_fpo" to meet the
> >             requirement of "less than 14 characters";
> >           - virtio_balloon_poll_free_page_hints:
> >               - run on condition when runstate_is_running() is true;
> >               - add a qemu spin lock to synchronize accesses to the free
> >                 page reporting related fields shared among the migration
> >                 thread and the optimization thread;
> >            - virtio_balloon_free_page_start: just return if
> >              runstate_is_running is false;
> >            - virtio_balloon_free_page_stop: access to the free page
> >              reporting related fields under a qemu spin lock;
> >            - virtio_balloon_device_unrealize/reset: call
> >              virtio_balloon_free_page_stop is the free page hint featur=
e is
> >              used;
> >            - virtio_balloon_set_status: call irtio_balloon_free_page_st=
op
> >              in case the guest is stopped by qmp when the optimization =
is
> >              running;
> > v3->v4:
> >      1) bitmap: add a new API to count 1s starting from an offset of a
> >         bitmap
> >      2) migration:
> >          - qemu_guest_free_page_hint: calculate
> >            ram_state->migration_dirty_pages by counting how many bits of
> >            free pages are truely cleared. If some of the bits were
> >            already 0, they shouldn't be deducted by
> >            ram_state->migration_dirty_pages. This wasn't needed for
> >            previous versions since we optimized bulk stage only,
> >            where all bits are guaranteed to be set. It's needed now
> >            because we extened the usage of this optimizaton to all stag=
es
> >            except the last stop&copy stage. From 2nd stage onward, there
> >            are possibilities that some bits of free pages are already 0.
> >       3) virtio-balloon:
> >           - virtio_balloon_free_page_report_status: introduce a new sta=
tus,
> >             FREE_PAGE_REPORT_S_EXIT. This status indicates that the
> >             optimization thread has exited. FREE_PAGE_REPORT_S_STOP mea=
ns
> >             the reporting is stopped, but the optimization thread still=
 needs
> >             to be joined by the migration thread.
> > v2->v3:
> >      1) virtio-balloon
> >          - virtio_balloon_free_page_start: poll the hints using a new
> >            thread;
> >          - use cmd id between [0x80000000, UINT_MAX];
> >          - virtio_balloon_poll_free_page_hints:
> >              - stop the optimization only when it has started;
> >              - don't skip free pages when !poison_val;
> >          - add poison_val to vmsd to migrate;
> >          - virtio_balloon_get_features: add the F_PAGE_POISON feature w=
hen
> >            host has F_FREE_PAGE_HINT;
> >          - remove the timer patch which is not needed now.
> >      2) migration
> >         - new api, qemu_guest_free_page_hint;
> >         - rs->free_page_support set only in the precopy case;
> >         - use the new balloon APIs.
> > v1->v2:
> >      1) virtio-balloon
> >          - use subsections to save free_page_report_cmd_id;
> >          - poll the free page vq after sending a cmd id to the driver;
> >          - change the free page vq size to VIRTQUEUE_MAX_SIZE;
> >          - virtio_balloon_poll_free_page_hints: handle the corner case
> >            that the free page block reported from the driver may cross
> >            the RAMBlock boundary.
> >      2) migration/ram.c
> >          - use balloon_free_page_poll to start the optimization
> >=20
> >=20
> > Wei Wang (5):
> >    bitmap: bitmap_count_one_with_offset
> >    migration: use bitmap_mutex in migration_bitmap_clear_dirty
> >    migration: API to clear bits of guest free pages from the dirty bitm=
ap
> >    virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
> >    migration: use the free page hint feature from balloon
> >=20
> >   balloon.c                                       |  58 +++++-
> >   hw/virtio/virtio-balloon.c                      | 241 +++++++++++++++=
+++++++--
> >   include/hw/virtio/virtio-balloon.h              |  27 ++-
> >   include/migration/misc.h                        |   2 +
> >   include/qemu/bitmap.h                           |  13 ++
> >   include/standard-headers/linux/virtio_balloon.h |   7 +
> >   include/sysemu/balloon.h                        |  15 +-
> >   migration/ram.c                                 |  73 ++++++-
> >   8 files changed, 406 insertions(+), 30 deletions(-)
>=20
> Nice optimization, for the first stage of=A0 current migration method, we=
 need to migrate all the pages of
> VM to destination,=A0 with this capability, we can reduce lots of unneces=
sary pages migrating.
>=20
> Just a small piece of advice, it is better to split the fourth patch into=
 small ones, to make it more easy
> for reviewing. Besides, should we make this capability an optional one, j=
ust like other migration capabilities do ?

That's already the case, one has to enable it in the balloon, and set
the iothread.

--=20
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

