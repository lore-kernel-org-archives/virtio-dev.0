Return-Path: <virtio-dev-return-8560-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 121E8986488
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Aug 2021 06:34:50 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <729bdaa3-d5c8-8c4c-4eb0-6f2b135d31a9@redhat.com>
References: <20210813145351.GA5604@quicinc.com> <87zgtgrt2n.fsf@redhat.com>
 <729bdaa3-d5c8-8c4c-4eb0-6f2b135d31a9@redhat.com>
Date: Wed, 18 Aug 2021 08:34:38 +0200
Message-ID: <87wnojs1kx.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2] virtio-mmio: Specify wait needed in driver during reset
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>, Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, tsoni@quicinc.com, pratikp@quicinc.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Aug 18 2021, Jason Wang <jasowang@redhat.com> wrote:

> =E5=9C=A8 2021/8/17 =E4=B8=8B=E5=8D=8811:26, Cornelia Huck =E5=86=99=E9=
=81=93:
>> On Fri, Aug 13 2021, Srivatsa Vaddagiri <quic_svaddagi@quicinc.com> wrot=
e:
>>
>>> Reset of a virtio-mmio device is initiated by writing 0 to its Status
>>> register. The reset operation itself may or may not be completed by the=
 time
>>> write instruction completes. For devices that are emulated in software,=
 writes
>>> to Status register are trapped and resumed only after the reset operati=
on is
>>> complete. Thus a driver can be assured of reset completion as soon as i=
ts write
>>> completes. That may not be however true in other cases, such as when vi=
rtio-mmio
>>> devices implemented directly in hardware. Driver's write to Status regi=
ster in
>>> such case could complete before the device reset operation is completed=
.
>>>
>>> Update the specification to indicate when a driver may need to poll for=
 reset
>>> completion before going ahead with the remaining initialization steps.
>>>     =20
>>> Suggested-by: Jason Wang <jasowang@redhat.com>
>>> Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
>>>
>>> ---
>>> V2->V1:
>>> - Use version 0x3 as an indication for drivers to poll for reset comple=
tion
>>>    (rather than base it on a new feature bit)
>>>
>>> Previous version can be found at:
>>>
>>> https://lists.oasis-open.org/archives/virtio-dev/202107/msg00168.html
>>>
>>>   content.tex | 11 +++++++----
>>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/content.tex b/content.tex
>>> index 7cec1c3..b6b30a0 100644
>>> --- a/content.tex
>>> +++ b/content.tex
>>> @@ -1730,9 +1730,9 @@ \subsection{MMIO Device Register Layout}\label{se=
c:Virtio Transport Options / Vi
>>>     }
>>>     \hline
>>>     \mmioreg{Version}{Device version number}{0x004}{R}{%
>>> -    0x2.
>>> +    0x3.
>>>       \begin{note}
>>> -      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio O=
ver MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio=
 Over MMIO / Legacy interface}) used 0x1.
>>> +      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio O=
ver MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio=
 Over MMIO / Legacy interface}) used 0x1. Devices that do not require drive=
rs to poll for reset completion can use 0x2. See \ref{devicenormative:Virti=
o Transport Options / Virtio Over MMIO / MMIO Device Register Layout} for m=
ore details.
>>>       \end{note}
>>>     }
>>>     \hline
>>> @@ -1916,7 +1916,7 @@ \subsection{MMIO Device Register Layout}\label{se=
c:Virtio Transport Options / Vi
>>>  =20
>>>   The device MUST return 0x74726976 in \field{MagicValue}.
>>>  =20
>>> -The device MUST return value 0x2 in \field{Version}.
>>> +The device MUST return either value 0x3 or 0x2 in \field{Version} base=
d on its reset behavior. Drivers trigger reset of a device by writing 0 to =
\field{Status}. The reset operation itself may or may not be completed by t=
he time write operation is complete. Devices whose reset operation complete=
s synchronously with the write operation are allowed to return value of 0x2=
 for \field{Version}. Other devices, whose reset operation can be incomplet=
e by the time write operation completes MUST return value 0x3 as an indicat=
ion for drivers to poll for reset completion.
>> Maybe I'm overthining this, but might that suddenly render some existing
>> device non-compliant? IIUC, we never mandated reset to be completed when
>> the write was completed, only kind of implied it. An existing device
>> will have version 2, but it might not be quite finished with reset after
>> the status write yet.
>
>
> Won't this break the driver probe/registering?

It might be racy, I guess; I'm not sure how other device or driver
implementations work.

>
> int register_virtio_device(struct virtio_device *dev)
>
> {
>
> ...
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We always start by resetti=
ng the device, in case a previous
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * driver messed it up.=
=C2=A0 This also tests that code path a=20
> little. */
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev->config->reset(dev);
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Acknowledge that we've see=
n the device. */
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_add_status(dev, VIRTIO=
_CONFIG_S_ACKNOWLEDGE);
>
> }
>
> Thanks
>
>
>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

