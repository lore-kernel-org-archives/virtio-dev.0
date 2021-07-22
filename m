Return-Path: <virtio-dev-return-8375-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8B294986312
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Jul 2021 10:57:56 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <b380151d-f20e-4e63-f1c3-a3f2220270cf@redhat.com>
References: <BY5PR02MB7073F1EAF729D30ACFFC67FCF9E49@BY5PR02MB7073.namprd02.prod.outlook.com>
 <b380151d-f20e-4e63-f1c3-a3f2220270cf@redhat.com>
Date: Thu, 22 Jul 2021 12:57:45 +0200
Message-ID: <87pmva7h06.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] virtio-mmio: Specify wait needed in driver
 during reset
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jul 22 2021, Jason Wang <jasowang@redhat.com> wrote:

> =E5=9C=A8 2021/7/22 =E4=B8=8B=E5=8D=885:19, Srivatsa Vaddagiri =E5=86=99=
=E9=81=93:
>> This is following up on the discussion we had earlier on MMIO reset=20
>> behavior:
>>
>> https://lists.oasis-open.org/archives/virtio-dev/202107/msg00012.html=20
>> <https://lists.oasis-open.org/archives/virtio-dev/202107/msg00012.html>
>>
>> Suggesting below change to spec to make it explicit what's expected in=
=20
>> driver. If this is accepted, I will follow up with a patch to Linux=20
>> driver.
>>
>> =3D=3D=3D
>>
>> Device reset is accomplished by writing 0 to Status register.=20
>> Explicitly note
>> that a driver needs to wait on Status register read returning 0 before=
=20
>> assuming that
>> device reset operation is complete.
>> Signed-off-by: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>
>
>
>
> I wonder if it deserves a feature bit.

Not sure what that feature bit should govern; if it is not negotiated,
the device must assume that the driver considers the reset to be
complete right after writing? I'm not sure what the device is supposed
to do then.

>
>
> Thanks
>
>
>>
>> diff --git a/content.tex b/content.tex
>> index 5c70a3c..7631be4 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -1985,6 +1985,10 @@ \subsubsection{Device=20
>> Initialization}\label{sec:Virtio Transport Options / Virti
>> =C2=A0and if its value is zero (0x0) MUST abort initialization and
>> =C2=A0MUST NOT access any other register.
>> +After writing 0 to \field{Status}, the driver MUST wait for a read of
>> +\field{Status} to return 0 before proceeding with the remaining steps o=
f
>> +initializing the device.

Maybe move this to the "MMIO Device Register Layout" driver normative
section.

Should that have a companion device normative statement (just as for
PCI)?

>> +
>> =C2=A0Drivers not expecting shared memory MUST NOT use the shared
>> =C2=A0memory registers.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

