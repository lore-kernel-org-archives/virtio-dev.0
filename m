Return-Path: <virtio-dev-return-8368-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1DA25986312
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Jul 2021 08:30:34 +0000 (UTC)
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <314d75d6-ae5c-6aaf-b796-a424c195aee4@opensynergy.com>
 <20210719113657.GI49078@e120937-lin>
From: Peter Hilber <peter.hilber@opensynergy.com>
Message-ID: <a2b796ef-3ce4-65a7-c9e6-4d9a97738c10@opensynergy.com>
Date: Thu, 22 Jul 2021 10:30:27 +0200
In-Reply-To: <20210719113657.GI49078@e120937-lin>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v6 00/17] Introduce SCMI transport based on VirtIO
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 19.07.21 13:36, Cristian Marussi wrote:
> On Thu, Jul 15, 2021 at 06:35:38PM +0200, Peter Hilber wrote:
>> On 12.07.21 16:18, Cristian Marussi wrote:
>>> Hi all,
>>>
>>
>> Hi Cristian,
>>
>> thanks for your update. Please find some additional comments in this rep=
ly
>> and the following.
>>
>> Best regards,
>>
>> Peter
>=20
> Hi Peter,
>=20
> thanks for the feedback.
>=20
>>
>>> While reworking this series starting from the work done up to V3 by
>>> OpenSynergy, I am keeping the original autorship and list distribution
>>> unchanged.
>>>
>>> The main aim of this rework, as said, is to simplify where possible the
>>> SCMI VirtIO support added in V3 by adding at first some new general
>>> mechanisms in the SCMI Transport layer.
>>>
>>> Indeed, after some initial small fixes, patches 05/06/07/08 add such ne=
w
>>> additional mechanisms to the SCMI core to ease implementation of more
>>> complex transports like virtio, while also addressing a few general iss=
ues
>>> already potentially affecting existing transports.
>>>
>>> In terms of rework I dropped original V3 patches 05/06/07/08/12 as no m=
ore
>>> needed, and modified where needed the remaining original patches to tak=
e
>>> advantage of the above mentioned new SCMI transport features.
>>>
>>> DT bindings patch has been ported on top of freshly YAML converted arm,=
scmi
>>> bindings.
>>>
>>> Moreover, since V5 I dropped support for polling mode from the virtio-s=
cmi
>>> transport, since it is an optional general mechanism provided by the co=
re
>>> to allow transports lacking a completion IRQ to work and it seemed a
>>> needless addition/complication in the context of virtio transport.
>>>
>>
>> Just for correctness, in my understanding polling is not completely opti=
onal
>> ATM. Polling would be required by scmi_cpufreq_fast_switch(). But that
>> requirement might be irrelevant for now.
>>
>=20
> Cpufreq core can use .fast_switch (scmi_cpufreq_fast_switch) op only if
> policy->fast_switch_enabled is true which in turn reported as true by
> the SCMI cpufreq driver iff SCMI FastChannels are supported by Perf
> implementation server side, but the SCMI Device VirtIO spec (5.17)
> explicitly does NOT support SCMI FastChannels as of now.
>=20
> Anyway, even though we should support in the future SCMI FastChannels on
> VirtIO SCMI transport, fastchannels are by defintion per-protocol/per-com=
mand/
> per-domain-id specific, based on sharedMem or MMIO, unidirectional and do=
 not
> even allow for a response from the platform (SCMIV3.0 4.1.1 5.3) so polli=
ng
> won't be a thing anyway unless I'm missing something.
>=20
> BUT you made a good point in fact anyway, because the generic perf->freq_=
set/get
> API CAN be indeed invoked in polling mode, and, even though we do not use=
 them
> in polling as of now (if not in the FastChannel scenario above) this coul=
d be a
> potential problem in general if when the underlying transport do not supp=
ort poll
> the core just drop any poll_completion=3Dtrue messages.
>=20
> So, while I still think it is not sensible to enable poll mode in SCMI Vi=
rtio,
> because would be a sort of faked polling and increases complexity, I'm no=
w
> considering the fact that maybe the right behaviour of the SCMI core in s=
uch a
> scenario would be to warn the user as it does now AND then fallback to us=
e
> non-polling, probably better if such a behavior is made condtional on som=
e
> transport config desc flag that allow such fallback behavior.
>=20
> Any thought ?
>=20

Maybe the SCMI protocols should request "atomic" instead of "polling"?=20
That semantics are the actual intent in my understanding. So the=20
"Introduce atomic support for SCMI transports" patch series [1] could=20
potentially address this?

Best regards,

Peter


[1] https://lkml.org/lkml/2021/7/12/3089

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

