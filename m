Return-Path: <virtio-dev-return-8369-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 28319986312
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Jul 2021 08:33:03 +0000 (UTC)
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-8-cristian.marussi@arm.com>
 <a163653c-51f9-adf0-c978-b747ddf2498a@opensynergy.com>
 <20210719091451.GF49078@e120937-lin>
From: Peter Hilber <peter.hilber@opensynergy.com>
Message-ID: <85868de4-54bf-cca8-3786-61a404b80117@opensynergy.com>
Date: Thu, 22 Jul 2021 10:32:58 +0200
In-Reply-To: <20210719091451.GF49078@e120937-lin>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v6 07/17] firmware: arm_scmi: Handle concurrent and
 out-of-order messages
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 19.07.21 11:14, Cristian Marussi wrote:
> On Thu, Jul 15, 2021 at 06:36:03PM +0200, Peter Hilber wrote:
>> On 12.07.21 16:18, Cristian Marussi wrote:

[snip]

>>> @@ -608,6 +755,7 @@ static int do_xfer(const struct scmi_protocol_handl=
e *ph,
>>>    =09=09=09      xfer->hdr.protocol_id, xfer->hdr.seq,
>>>    =09=09=09      xfer->hdr.poll_completion);
>>> +=09xfer->state =3D SCMI_XFER_SENT_OK;
>>
>> To be completely safe, this assignment could also be protected by the
>> xfer->lock.
>>
>=20
> In fact this would be true being xfer->lock meant to protect the state bu=
t it
> seemed to me unnecessary here given that this is a brand new xfer with a
> brand new (monotonic) seq number so that any possibly late-received msg w=
ill
> carry an old stale seq number certainly different from this such that can=
not be
> possibly mapped to this same xfer. (but just discarded on xfer lookup in
> xfer_command_acquire)
>=20
> The issue indeed could still exist only for do_xfer loops (as you pointed=
 out
> already early on) where the seq_num is used, but in that case on a timeou=
t we
> would have already bailed out of the loop and reported an error so any ti=
med-out
> late received response would have been anyway discarded; so at the end I =
thought
> I could avoid spinlocking here.
>=20
> Thanks,
> Cristian
>=20

I mostly meant to refer to the possibility of a very fast response not=20
seeing this assignment, since the next line is

>  =09ret =3D info->desc->ops->send_message(cinfo, xfer);

and during that a regular scmi_rx_callback(), reading xfer->state, can=20
already arrive. But maybe this is too theoretical.

Best regards,

Peter

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

