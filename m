Return-Path: virtio-dev-return-7615-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 24703985D4A
	for <virtio-dev@lists.oasis-open.org>; Fri, 24 Jul 2020 13:14:13 +0000 (UTC)
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-2-ndragazis@arrikto.com> <87v9inv26c.fsf@linaro.org>
 <20200717092635.GB128195@stefanha-x1.localdomain>
 <99b30044-f59c-c9b7-df3a-3a1eb4001042@arrikto.com>
 <20200723061513.GA268427@stefanha-x1.localdomain>
From: Nikos Dragazis <ndragazis@arrikto.com>
Message-ID: <d7a8229d-b44d-3fa3-e4a4-8dde6e71c2be@arrikto.com>
Date: Fri, 24 Jul 2020 16:14:10 +0300
MIME-Version: 1.0
In-Reply-To: <20200723061513.GA268427@stefanha-x1.localdomain>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v5 01/10] vhost-user: add vhost-user device
 type
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 23/7/20 9:15 =CF=80.=CE=BC., Stefan Hajnoczi wrote:

> On Fri, Jul 17, 2020 at 02:17:13PM +0300, Nikos Dragazis wrote:
>> On 17/7/20 12:26 =CE=BC.=CE=BC., Stefan Hajnoczi wrote:
>>
>>> On Thu, Jul 16, 2020 at 05:45:47PM +0100, Alex Benn=C3=A9e wrote:
>>>> Nikos Dragazis <ndragazis@arrikto.com> writes:
>>>>> diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
>>>>> new file mode 100644
>>>>> index 0000000..ac96dc2
>>>>> --- /dev/null
>>>>> +++ b/virtio-vhost-user.tex
>>>>> @@ -0,0 +1,292 @@
>>>>> +\section{Vhost-user Device Backend}\label{sec:Device Types / Vhost-u=
ser Device Backend}
>>>>> +
>>>>> +The vhost-user device backend facilitates vhost-user device emulatio=
n through
>>>>> +vhost-user protocol exchanges and access to shared memory.  Software=
-defined
>>>>> +networking, storage, and other I/O appliances can provide services t=
hrough this
>>>>> +device.
>>>>> +
>>>>> +This section relies on definitions from the \hyperref[intro:Vhost-us=
er
>>>>> +Protocol]{Vhost-user Protocol}.  Knowledge of the vhost-user protoco=
l is a
>>>>> +prerequisite for understanding this device.
>>>>> +
>>>>> +The \hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol} was or=
iginally
>>>>> +designed for processes on a single system communicating over UNIX do=
main
>>>>> +sockets.  The virtio vhost-user device backend allows the vhost-user=
 slave to
>>>>> +communicate with the vhost-user master over the device instead of a =
UNIX domain
>>>>> +socket.  This allows the slave and master to run on two separate
>>>>> systems such
>>>> I realise we already have the terms master/slave baked into the
>>>> vhost-user spec but perhaps we could find better wording? The vhost
>>>> documentation describes thing in terms of who owns the virtqueues (the
>>>> drive) and who processes the requests (the device). There may be bette=
r
>>>> terminology to use.
>>> "backend" is now commonly used instead of "slave". There is no new term
>>> for "master" yet. I suggest replacing "slave" with "backend" in this
>>> patch.
>> Makes sense. Some observations:
>>
>> 1. Since "backend" is used instead of "slave", why "frontend" is not
>>  =C2=A0=C2=A0 used instead of "master"? Also, why does the vhost-user sp=
ec use the
>>  =C2=A0=C2=A0 terms"slave" and "backend" interchangeably and doesn't jus=
t drop the
>>  =C2=A0=C2=A0 term"slave"completely?
> Using "frontend" and "backend" sounds good. Do you want to send a patch
> to qemu.git docs/interop/vhost-user.rst?

OK, I will.

>
> The vhost-user spec grew organically and few people have spent time on
> polishing it, making it consistent, etc.
>
> Stefan

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

