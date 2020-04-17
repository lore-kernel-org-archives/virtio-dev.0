Return-Path: virtio-dev-return-7097-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A5AE6986076
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Apr 2020 06:28:37 +0000 (UTC)
Date: Fri, 17 Apr 2020 02:28:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200417021335-mutt-send-email-mst@kernel.org>
References: <20200416192809.8763.19308.stgit@localhost.localdomain>
 <20200416180845-mutt-send-email-mst@kernel.org>
 <CAKgT0UfWHHyCekU+dReNfhAa6u6FNbm7Ff5wmyN58d1VymmAMA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfWHHyCekU+dReNfhAa6u6FNbm7Ff5wmyN58d1VymmAMA@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH] virtio-balloon: Disable free page
 hinting/reporting if page poison is disabled
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, David Hildenbrand <david@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Apr 16, 2020 at 04:52:42PM -0700, Alexander Duyck wrote:
> On Thu, Apr 16, 2020 at 3:13 PM Michael S. Tsirkin <mst@redhat.com> wrote=
:
> >
> > On Thu, Apr 16, 2020 at 12:30:38PM -0700, Alexander Duyck wrote:
> > > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > >
> > > If we have free page hinting or page reporting enabled we should disa=
ble it
> > > if the pages are poisoned or initialized on free and we cannot notify=
 the
> > > hypervisor.
> > >
> > > Fixes: 5d757c8d518d ("virtio-balloon: add support for providing free =
page reports to host")
> > >
> > > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> >
> > Why not put this logic in the hypervisor?
>=20
> I did that too. This is to cover the case where somebody is running
> the code prior to my QEMU changes where the page poison feature wasn't
> being enabled.


Hmm so that one looks like a QEMU bug (does not expose poison flag).  In
the past we just said need to fix the bug where it's found unless the
issue is very widespread and major.  Let's assume QEMU learns to always
expose POISON with HINT.  Then this configuration (HINT && !POISON)
allows us to detect old QEMU (pre your changes).

I am also interested in the following question:
Is this good for anything? In particular are there any bugs in HINT
we can fix using this hack?

E.g. I know HINT does not obey MUST_TELL_HOST under OOM.  But that
unfortunately is a guest not a host bug, so this hack does not seem
useful.


> > We don't know what hypervisor uses the hints for.
>=20
> I agree, but at the same time the way the feature was originally coded
> it was only checked if the FREE_PAGE_HINT feature was enabled. The
> assumption there is that if we have page poison data and want to use
> hints we need to report it. In my mind if we ever want to switch over
> to the page reporting style setup for page hinting in the future we
> will need to have it behave in a sane manner. So disabling it if we
> have a poison value we need to report, but have no mechanism to report
> it makes sense to me.
>=20
> The actual likelihood of us encountering this case should be pretty
> low anyway since it is not that common to have page poisoning or
> init_on_free enabled.
>=20
> > Yes you can not just drop them but you can maybe do
> > other things such as MADV_SOFT_OFFLINE.
> >
> > Finally, VIRTIO_BALLOON_F_FREE_PAGE_HINT does nothing
> > at all unless guest gets the command from hypervisor,
> > so there isn't even any overhead.
>=20
> The problem is we cannot communicate the full situation to the
> hypervisor without the page poison feature being present. As such I
> would worry about that backfiring on us due to the hypervisor acting
> on incomplete data.


I'll try to think about VIRTIO_BALLOON_F_FREE_PAGE_HINT situation
over the weekend. But for the new page reporting, why not
assume host implementation will be sane?

--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

