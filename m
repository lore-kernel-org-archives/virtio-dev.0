Return-Path: virtio-dev-return-7798-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BE15398602C
	for <virtio-dev@lists.oasis-open.org>; Fri, 18 Sep 2020 21:24:51 +0000 (UTC)
References: <20200824143708.5664-1-ndragazis@arrikto.com>
 <20200824143708.5664-6-ndragazis@arrikto.com> <878sd8xrpc.fsf@linaro.org>
From: Nikos Dragazis <ndragazis@arrikto.com>
Message-ID: <18a0f437-8917-b9b6-4370-587c02f83e3a@arrikto.com>
Date: Sat, 19 Sep 2020 00:24:48 +0300
MIME-Version: 1.0
In-Reply-To: <878sd8xrpc.fsf@linaro.org>
Subject: [virtio-dev] Re: [PATCH 05/11] doorbells: Introduce doorbells
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 17/9/20 8:01 =CE=BC.=CE=BC., Alex Benn=C3=A9e wrote:

> Nikos Dragazis <ndragazis@arrikto.com> writes:
>
>> Introduce doorbells as a new virtio device resource.
>>
>> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
>> ---
>>   content.tex   |  2 ++
>>   doorbells.tex | 12 ++++++++++++
>>   2 files changed, 14 insertions(+)
>>   create mode 100644 doorbells.tex
>>
>> diff --git a/content.tex b/content.tex
>> index 94a3693..38ed709 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -373,6 +373,8 @@ \section{Driver Notifications} \label{sec:Virtqueues=
 / Driver notifications}
>>  =20
>>   \input{shared-mem.tex}
>>  =20
>> +\input{doorbells.tex}
>> +
>>   \chapter{General Initialization And Device Operation}\label{sec:Genera=
l Initialization And Device Operation}
>>  =20
>>   We start with an overview of device initialization, then expand on the
>> diff --git a/doorbells.tex b/doorbells.tex
>> new file mode 100644
>> index 0000000..e917536
>> --- /dev/null
>> +++ b/doorbells.tex
>> @@ -0,0 +1,12 @@
>> +\section{Doorbells}\label{sec:Basic Facilities of a Virtio device / Doo=
rbells}
>> +
>> +A doorbell is a device register that triggers a notification to the
>> +device when accessed by the driver.
>> +
>> +Doorbells are an additional facility available to devices that need to
>> +support receiving driver notifications for events other than virtqueue
>> +activity (i.e., notifications that are device-specific).
>> +
>> +A device may be exporting multiple doorbells to the driver.
>> +
>> +The location of doorbells is found in a transport-specific way.
> I just realised we don't specify anything about delivery. Should we say
> something about lack of acknowledgement or guarantee that the
> notification is delivered here?
>

I don't know. Should we? Based on the spec, the driver knows that each
access delivers a notification to the device. So, I think it is clear that
notifications cannot be lost. An acknowledgment would make sense if
notifications could be lost.

Regarding the rate at which the device can actually process these
notifications, I think this is a whole different story.

If you have something more specific in mind, please share it.

--Nikos

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

