Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB63D1BF31;
	Tue, 21 May 2024 02:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716260265; cv=none; b=OBJHv4cU43YmqhSbaG9/V9qdMMJFYXPUsMOpWwIQYm3XzuSdUABaA3iyz0tN7kCz5yja1HGt3qznYjbs+MwN4fXxfgGb4S0x54Vv/RtqwyRNHpO78ytD2fG+tZn8+JVoqmwi8bb+PhjeAs8OfknC9BkowzkyneuUGhrsC+Wawb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716260265; c=relaxed/simple;
	bh=LMyrcHaQ9oa9QZHlgW1qY8iyI52X5Np7OE/T+PuKg/Q=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=KFoHLwd6e/JOmPr+z8ZVmBKE/dEOM70l51bRP9Ihbo8YdvqAI3bEeY9F6+usvX1gNySuM6ijJ3vlj/khq5mXY+iCsKsRAim0hTkFefm7guYu5n+q65Vvv3ooepdp32H7nLS6KWQMychkkpFUBOvWl2Ac0wYE9uCXytXdBaGL4eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YDdRYmAN; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YDdRYmAN"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716260253; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=6ewAP595xU2R823E+chSLfBIp0S5hLjyXxnEU5nWBa4=;
	b=YDdRYmANfm9yiqi4NXD2ybwvVoROZWNgmk8hesB2DzzrnFrcP0CTxYYBB8cPWRqYaSWkI6jZcDQy71AItra5sHHS0OXuyxukpYp/mYuJPwoDVfwdJ95j9ugj3ZqHSq4W2pWpAAC14Q6BQRf6RDdIsbTmnd+h5Wl/28O+HiKCekI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W6wB5h1_1716260251;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W6wB5h1_1716260251)
          by smtp.aliyun-inc.com;
          Tue, 21 May 2024 10:57:32 +0800
Message-ID: <1716258261.2936878-1-hengqi@linux.alibaba.com>
Subject: Re: RE: RE: RE: [PATCH v2] virtio-net: improve description of default coalescing parameters
Date: Tue, 21 May 2024 10:24:21 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "virtio-comment@lists.linux.dev" <virtio-comment@lists.linux.dev>,
 "virtio-dev@lists.linux.dev" <virtio-dev@lists.linux.dev>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S .   Tsirkin" <mst@redhat.com>
References: <20240513125634.102955-1-hengqi@linux.alibaba.com>
 <PH0PR12MB54815E887B1010D2AE96CEACDCE32@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1715665954.5198457-1-hengqi@linux.alibaba.com>
 <PH0PR12MB5481EAD646ECB0CBF979FFC7DCE32@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1715673206.4680686-3-hengqi@linux.alibaba.com>
 <PH0PR12MB5481CAFB5B39638566238063DCE32@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481CAFB5B39638566238063DCE32@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>

On Tue, 14 May 2024 13:09:32 +0000, Parav Pandit <parav@nvidia.com> wrote:
>=20
> > From: Heng Qi <hengqi@linux.alibaba.com>
> > Sent: Tuesday, May 14, 2024 1:23 PM
> >=20
> > On Tue, 14 May 2024 07:48:55 +0000, Parav Pandit <parav@nvidia.com>
> > wrote:
> > >
> > >
> > > > From: Heng Qi <hengqi@linux.alibaba.com>
> > > > Sent: Tuesday, May 14, 2024 11:23 AM
> > > >
> > > > On Tue, 14 May 2024 03:59:52 +0000, Parav Pandit <parav@nvidia.com>
> > > > wrote:
> > > > > Hi Heng,
> > > > >
> > > > >
> > > > > > From: Heng Qi <hengqi@linux.alibaba.com>
> > > > > > Sent: Monday, May 13, 2024 6:27 PM
> > > > > >
> > > > > > Currently, a device may initialize each vq's coalescing
> > > > > > parameters to empirically non-zero values, so the description of
> > > > > > this part is supplemented for the virtio spec.
> > > > > >
> > > > > Currently the spec says to initialize the vq's coalescing paramet=
ers to zero.
> > > > >
> > > > > Spec snippet: " Upon reset, a device MUST initialize all
> > > > > coalescing
> > > > parameters to 0."
> > > > >
> > > > > So I didn't understand why you say "current the device may initia=
lize".
> > > > >
> > > > > Do you mean, you want to change the spec to say, by default the
> > > > > device has
> > > > chosen to set zero or non-zero default parameter as it likes.
> > > > > (and not zero).
> > > >
> > > > Yes.
> > > >
> > > > If a device supports interrupt coalescing moderation, it usually has
> > > > a non- zero default value to provide better performance.
> > > When VIRTIO_NET_F_VQ_NOTF_COAL or VIRTIO_NET_F_NOTF_COAL is not
> > negotiated, the device can apply any notification coalescing value.
> > > (assuming EVENT_IDX is off).
> > >
> > > But when they above features are negotiated, it is expected that
> > > driver is going to driver it,
> >=20
> > The driver drives the runtime parameters without conflicting with the i=
nitial
> > default values.
> > And most users/drivers without dim enable may not drive it.
> >=20
> There is no conflict in runtime or default parameters.
> For driver it starts after 10msec or 4 minutes, both are runtime paramete=
rs.
>=20
> > The device need to be defensive about default performance.
> >=20
> The device can surely offer the default performance with non zero default=
 values.

That's what I'm mentioning.

>=20
> > >in such case what is the good motivation to start with some arbitrary =
value?
> > >
> > > > I'm trying to fix this, and
> > > > we shouldn't force the device to always initialize with 0.
> > > >
> > > If driver is in control, driver decides what values to set.
> > > And hence, arbitrary value is
> >=20
> > Then maybe the driver is never set and the device uses a 0 which messes=
 up
> > most data scenarios.
> >=20
> If driver does not want to set it, why did it enable the feature in first=
 place?
> So asking again, is it because driver enabled featured too early in the d=
river load sequence, and not DIM is also disabled?

I don't see the connection.

>=20
> If feature is negotiated, than DIM can be enabled by default, and therefo=
re there is no need for the defaults?

Right. But if DIM is not enabled (pls remember that DIM is just one of the
application scenarios of VQ_NOTF_COAL, right?), the user can query the init=
ial
value of the device, which may be any value.

>=20
> Or you are saying, that enabling DIM as default has some issue, and until=
 that point you prefer to have some default in the device?

Partly true. The complete purpose is that the device can have any default v=
alues
(0 or non-zero).

>=20
> > Cloud vendors cannot do this. And I don=E2=80=99t seem to see any inter=
ference with
> > other devices from this proposal?
> > If the device does not want a non-zero value, a value of 0 can be used =
as the
> > default value.
> >=20
> I didn=E2=80=99t understand above.
>=20
> > >
> > > > Especially when the DIM is disabled from the enabled state, allowing
> > > > the driver to restore default parameters for device will prevent
> > > > occasional performance degradation.
> > > >
> > > When DIM is disabled, do you mean driver does not have any good defau=
lts?
> >=20
> > DIM is not guaranteed to have a friendly value when disabled.
> >=20
> I didn=E2=80=99t follow.=20
>=20
> (a) When DIM is enabled, DIM decides the value.
> (b) When DIM is disabled, zero is not good default in the device. Did I u=
nderstand right?
>=20
> I agree with (a) and (b).

Right.

>=20
> > > I guess this issue surfaces from the feature negotiation limitation t=
hat, it
> > must be done early enough before DRIVER_OK.
> > > And DIM is still disabled in driver.
> >=20
> > We lack the capability filed of default coalescing parameters, so GET i=
s used to
> > alleviate this.
> >=20
> When GET is not supported, ethtool should get -ENOSUPP instead of 0.

We don't have a separate feature bit for GET, right? So if VQ_NOTF_COAL is
negotiated, the device supports the GET command.

>=20
> > >
> > > That explains.
> > >
> > > Commit log needs to explain this limitation and the gain by relaxing =
it to be
> > non-zero.
> > >
> > > Any reason DIM is disabled by default in the driver?
> > > If VQ_NOTF_COAL is supported by device, DIM should be enabled by
> > default.
> >=20
> > virtio-net support for netdim needs to be optimized. Of course, I also =
found
> > that other network cards also have optimization points.
> >=20
> > I'm trying to enable DIM for upstream by default, after I've done the p=
rofile list
> > tuning etc.
> >=20
> > >
> > > > >
> > > > > > Since the VIRTIO_NET_F_NOTF_COAL feature does not provide a
> > > > > > related GET command or config field, we still consider its defa=
ult values
> > to be 0.
> > > > > >
> > > > > The behavior for VIRTIO_NET_F_NOTF_COAL and
> > > > VIRTIO_NET_F_VQ_NOTF_COAL can stay same for the default value.
> > > > > Can you please explain the motivation for running different
> > > > > default values
> > > > for two different features in this commit log?
> > > >
> > > > The current spec leaves coalescing parameters for both features at =
0.
> > > >
> > > > F_VQ_NOTF_COAL provides a GET command, that is, non-zero 0 can be
> > > > obtained by the driver from the device, but F_NOTF_COAL does not
> > > > have a similar GET command.
> > > >
> > > GET command doesn't give the ability to define the defaults.
> > > So both can have non zero defaults.
> >=20
> > Makes sense.
> >=20
> > >
> > > > So when vq reset occurs or dim is disabled from the enabled state,
> > > > the driver with F_VQ_NOTF_COAL negotiated has the ability to restore
> > > > non-zero values, but only when F_NOTF_COAL is negotiated, the driver
> > > > has no path to obtain the non-zero value, let alone restore non-zero
> > values.
> > > >
> > > When F_NOTF_COAL is negotiated, if the device has its non zero defaul=
ts,
> > why does driver need to restore anything?
> >=20
> > Yes, device will set these.
> >
> Ok. so no restore needed.
> =20
> > > > >
> > > > > > Suggested-by: Jason Wang <jasowang@redhat.com>
> > > > > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > > ---
> > > > > > v1->v2:
> > > > > >   - Update description @Jason.
> > > > > >
> > > > > >  device-types/net/description.tex | 22 +++++++++++++++-------
> > > > > >  1 file changed, 15 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/device-types/net/description.tex b/device-
> > > > > > types/net/description.tex index 61cce1f..cf4b12c 100644
> > > > > > --- a/device-types/net/description.tex
> > > > > > +++ b/device-types/net/description.tex
> > > > > > @@ -1805,6 +1805,10 @@ \subsubsection{Control
> > > > > > Virtqueue}\label{sec:Device Types / Network Device / Devi
> > > > > >
> > > > > >  The device may generate notifications more or less frequently
> > > > > > than specified by set commands of the VIRTIO_NET_CTRL_NOTF_COAL
> > class.
> > > > > >
> > > > > > +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is offered, the device
> > > > > > +may initialize the coalescing parameters for each transmit or
> > > > > > +receive virtqueue to non-zero values, otherwise, to 0, which
> > > > > > +are called default
> > > > > > coalescing parameters.
> > > > > > +
> > > > > Instead of 'offered', it should be 'negotiated'. Because if may be
> > > > > offered,
> > > > but driver may not have enabled it.
> > > >
> > > > I do not think so.
> > > >
> > > > Even if the driver does not negotiate, as long as the device has the
> > > > ability to adjust coalescing parameters (i.e. offered), the device
> > > > will initialize any values.
> > > >
> > > The device can initialize coalescing parameters regardless of VQ_NOTF=
_COAL
> > offered or not.
> > >
> >=20
> > Right.
> >=20
> > >
> > > > >
> > > > > >  If coalescing parameters are being set, the device applies the
> > > > > > last coalescing parameters set for a  virtqueue, regardless of
> > > > > > the command used to set the parameters. Use the following
> > > > > > command sequence  with two pairs of virtqueues as an example:
> > > > > > @@ -1873,6 +1877,10 @@ \subsubsection{Control
> > > > > > Virtqueue}\label{sec:Device Types / Network Device / Devi
> > > > > >
> > > > > >  The driver MUST ignore the values of coalescing parameters
> > > > > > received from the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if
> > > > > > the device responds with VIRTIO_NET_ERR.
> > > > > >
> > > > > > +If the VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated, the
> > > > > > +driver
> > > > > > MUST
> > > > > > +get coalescing parameters for each enabled transmit or receive
> > > > > > +virtqueue through the VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET
> > > > command
> > > > > > after a successful device reset.
> > > > > > +
> > > > > The driver is free to not call GET call at all. It can always jus=
t do set.
> > > > > So it cannot be must requirement for the driver to get them.
> > > >
> > > > This is mainly forced to MUST during the probe phase.
> > > > Other timings, the existing spec has already described it clearly.
> > > >
> > > I don't see it is needed to force driver to read.
> > > Why is it must for the driver to read it? It can operate without read.
> >=20
> > Otherwise the device has a non-zero default value, but users using etht=
ool -c
> > see a value of 0.
> >=20
> When GET is supported, ethtool callback should query the current value.
> Driver can read it once at start time, but it is not a MUST requirement.
> Driver can read it runtime too. It is the driver implementation choice.
> We don=E2=80=99t need to tell in the spec, when driver MUST read it.

I agree with this.

>=20
> > >
> > > > >
> > > > > The wording should be, the driver MAY get ...
> > > > >
> > > > > >  \devicenormative{\subparagraph}{Notifications
> > > > > > Coalescing}{Device Types / Network Device / Device Operation /
> > > > > > Control Virtqueue / Notifications Coalescing}
> > > > > >
> > > > > >  The device MUST ignore \field{reserved}.
> > > > > > @@ -1884,18 +1892,18 @@ \subsubsection{Control
> > > > > > Virtqueue}\label{sec:Device Types / Network Device / Devi  The
> > > > > > device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and
> > > > > > VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with
> > > > VIRTIO_NET_ERR if
> > > > > > the designated virtqueue is not an enabled transmit or receive
> > virtqueue.
> > > > > >
> > > > > > -Upon disabling and re-enabling a transmit virtqueue, the device
> > > > > > MUST set the coalescing parameters of the virtqueue -to those
> > > > > > configured through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
> > > > command, or,
> > > > > > if the driver did not set any TX coalescing parameters, to 0.
> > > > > > -
> > > > > > -Upon disabling and re-enabling a receive virtqueue, the device
> > > > > > MUST set the coalescing parameters of the virtqueue -to those
> > > > > > configured through the VIRTIO_NET_CTRL_NOTF_COAL_RX_SET
> > command,
> > > > > > or, if the driver did not set any RX coalescing parameters, to =
0.
> > > > > > -
> > > > > >  The behavior of the device in response to set commands of the
> > > > > > VIRTIO_NET_CTRL_NOTF_COAL class is best-effort:
> > > > > >  the device MAY generate notifications more or less frequently
> > > > > > than specified.
> > > > > >
> > > > > >  A device SHOULD NOT send used buffer notifications to the
> > > > > > driver if the notifications are suppressed, even if the
> > > > > > notification conditions are
> > > > met.
> > > > > >
> > > > > > -Upon reset, a device MUST initialize all coalescing parameters=
 to 0.
> > > > > > +Upon reset, a device MUST set default coalescing parameters for
> > > > > > +all transmit or receive virtqueues.
> > > > > > +
> > > > > The device MAY set parameters to zero or non zero values..
> > > >
> > > > Ok.
> > > >
> > > > > I am still missing the motivation part of why to set non zero
> > > > > value, even if
> > > > the driver has negotiated the feature.
> > > >
> > > > Please see the above description.
> > > >
> > > If I understood is right, the case is:
> > > _VQ_NOTF_COAL is negotiated, and DIM is disabled.
> > > And device is unable to apply some good non zero defaults.
> >=20
> >=20
> > If _VQ_NOTF_COAL is negotiated, and DIM is disabled:
> >=20
> > 1. The device wants to set a non-zero value for good perf,
> >    but the user sees a value of 0.
> >=20
> The only limitation that we want to remove is, on device reset, the devic=
e may have any default value.

Right, and the driver may query the value using the GET command.

>=20
> > 2. When the user has not actively modified the value, DIM switches from=
 the
> >    enabled state to the disabled state, then the driver expects to issu=
e a
> >    setting command with a default value. To avoid performance degradati=
on
> >    caused by a bad value.
> >=20
> This #2 seems like some hack. Should I read the Linux code in this area?

No. This is some kind of performance optimization at the code level. When D=
IM is
turned off, the driver configures default values for the device to avoid an=
y big
performance regression.

>=20
> > We assume that most users do not have the prerequisite knowledge to mod=
ify
> > coalecing parameters.
> >=20
> Right. Hence the DIM should be used.
> When DIM is not used, a non zero default is good to have.
> (without forcing the driver to read it).

+1

Thanks.

>=20
> > Thanks.
> >=20
> > >
> > > Right?
> > >
> > >
> > > > Thanks.
> > > >
> > > > >
> > > > > > +Regardless of whether the coalescing parameters have been
> > > > > > +overridden by set commands from the
> > VIRTIO_NET_CTRL_NOTF_COAL
> > > > > > +class, upon
> > > > > > disabling
> > > > > > +and re-enabling a transmit or receive virtqueue, the device
> > > > > > +MUST set the previous parameters for the virtqueue.
> > > > > >
> > > > > >  \paragraph{Device Statistics}\label{sec:Device Types / Network
> > > > > > Device / Device Operation / Control Virtqueue / Device
> > > > > > Statistics}
> > > > > >
> > > > > > --
> > > > > > 2.32.0.3.g01195cf9f
> > > > >
>=20
