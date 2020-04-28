Return-Path: virtio-dev-return-7195-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B5D91985E1A
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Apr 2020 10:15:42 +0000 (UTC)
Date: Tue, 28 Apr 2020 12:15:30 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200428101530.rzbvjzncfvlfexvn@sirius.home.kraxel.org>
References: <20200330163413.975345-1-anton.yakovlev@opensynergy.com>
 <ceb22f05-67d5-e897-e31f-e07623a1e758@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <ceb22f05-67d5-e897-e31f-e07623a1e758@opensynergy.com>
Subject: [virtio-dev] Re: [PATCH v8] virtio-snd: add virtio sound device specification
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Apr 14, 2020 at 12:41:52PM +0200, Anton Yakovlev wrote:
> Hi all,
>=20
> There seems to be no additional comments here. Is it ready to vote then?

Yes, I think so.  I see you did that meanwhile.

> On 30.03.2020 18:34, Anton Yakovlev wrote:
> > From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> >=20
> > This patch proposes virtio specification for a new virtio sound device,
> > that may be useful in case when having audio is required but a device
> > passthrough or emulation is not an option.
> >=20
> > Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

