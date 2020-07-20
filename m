Return-Path: virtio-dev-return-7597-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EBC5998431B
	for <virtio-dev@lists.oasis-open.org>; Mon, 20 Jul 2020 09:37:49 +0000 (UTC)
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-2-ndragazis@arrikto.com> <87v9inv26c.fsf@linaro.org>
 <20200717092635.GB128195@stefanha-x1.localdomain>
 <99b30044-f59c-c9b7-df3a-3a1eb4001042@arrikto.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <99b30044-f59c-c9b7-df3a-3a1eb4001042@arrikto.com>
Message-ID: <874kq2edcm.fsf@linaro.org>
Date: Mon, 20 Jul 2020 10:37:45 +0100
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v5 01/10] vhost-user: add vhost-user device
 type
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


Nikos Dragazis <ndragazis@arrikto.com> writes:

> On 17/7/20 12:26 =CE=BC.=CE=BC., Stefan Hajnoczi wrote:
>
>> On Thu, Jul 16, 2020 at 05:45:47PM +0100, Alex Benn=C3=A9e wrote:
>>> Nikos Dragazis <ndragazis@arrikto.com> writes:
>>>> diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
>>>> new file mode 100644
>>>> index 0000000..ac96dc2
>>>> --- /dev/null
>>>> +++ b/virtio-vhost-user.tex
>>>> @@ -0,0 +1,292 @@
>>>> +\section{Vhost-user Device Backend}\label{sec:Device Types / Vhost-us=
er Device Backend}
>>>> +
>>>> +The vhost-user device backend facilitates vhost-user device emulation=
 through
>>>> +vhost-user protocol exchanges and access to shared memory.  Software-=
defined
>>>> +networking, storage, and other I/O appliances can provide services th=
rough this
>>>> +device.
>>>> +
>>>> +This section relies on definitions from the \hyperref[intro:Vhost-use=
r
>>>> +Protocol]{Vhost-user Protocol}.  Knowledge of the vhost-user protocol=
 is a
>>>> +prerequisite for understanding this device.
>>>> +
>>>> +The \hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol} was ori=
ginally
>>>> +designed for processes on a single system communicating over UNIX dom=
ain
>>>> +sockets.  The virtio vhost-user device backend allows the vhost-user =
slave to
>>>> +communicate with the vhost-user master over the device instead of a U=
NIX domain
>>>> +socket.  This allows the slave and master to run on two separate
>>>> systems such
>>> I realise we already have the terms master/slave baked into the
>>> vhost-user spec but perhaps we could find better wording? The vhost
>>> documentation describes thing in terms of who owns the virtqueues (the
>>> drive) and who processes the requests (the device). There may be better
>>> terminology to use.
>> "backend" is now commonly used instead of "slave". There is no new term
>> for "master" yet. I suggest replacing "slave" with "backend" in this
>> patch.
>
> Makes sense. Some observations:
>
> 1. Since "backend" is used instead of "slave", why "frontend" is not
>     used instead of "master"? Also, why does the vhost-user spec use the
>     terms"slave" and "backend" interchangeably and doesn't just drop the
>     term"slave"completely?
>
> 2. The term "driver" cannot replace the term "master" for one more
>     reason: they refer todifferent things. The master is the hypervisor,
>     not the driver. The driver doesn't even know that the device is
>     implemented via the vhost-user mechanism.
>
>>
>> Using "device"/"driver" would cause confusion here because
>> both virtio-vhost-user itself and the vhost device being emulated
>> already use those terms. We need to be able to differentiate between the
>> vhost-level master/backend concept and the VIRTIO driver/device concept.
>>
>>>> +as a virtual machine and a hypervisor.
>>> This implies type-2 setups, depending on where you define the
>>> hypervisor. Could the language be extended: " or device in one virtual
>>> machine with the driver operating in another"?
>> Traditional vhost-user looks like this:
>>
>>         VM
>>     virtio-net
>>
>>         |
>>
>>        VMM                     vhost-user-net process
>> vhost-user master  ------------ vhost-user backend
>>
>> The vhost-user protocol communication is not visible to the VM. It just
>> sees a virtio-net device.
>>
>> With virtio-vhost-user it looks like this:
>>
>>      Driver VM                      Device VM
>> virtio-net driver             virtio-vhost-user driver
>>
>>         |                               |
>>
>>     Driver VMM                      Device VMM
>> vhost-user master  ------------ vhost-user backend
>>
>> Here the master is running on the "hypervisor" (it's the Driver VMM) and
>> the backend is running inside the Device VM.
>>
>> This spec does not require that the Driver VMM and Device VMM
>> communicate over the traditional vhost-user UNIX domain socket.
>>
>> I'm not sure what "device in one virtual machine with the driver
>> operating in another" means. The main point of the paragraph is that a
>> VIRTIO device for vhost-user allows the master and backend to run on
>> separate systems (no longer tied to a UNIX domain socket).
>>
>> Can you think of a rewording that captures this better?
>>
>>>> +\begin{description}
>>>> +\item[\field{status}] contains the vhost-user operational status.  Th=
e default
>>>> +    value of this field is 0.
>>>> +
>>>> +    The driver sets VIRTIO_VHOST_USER_STATUS_SLAVE_UP to indicate rea=
diness for
>>>> +    the vhost-user master to connect.  The vhost-user master cannot c=
onnect
>>>> +    unless the driver has set this bit first.
>>> I suspect some deployment diagrams are going to help here. Does this
>>> imply that there is something in userspace connected to the slave kerne=
l
>>> ready to process messages or just that the driver in the kernel is read=
y
>>> to accept messages?
>> That is beyond the scope of the spec. There is no requirement for
>> implementing the virtio-vhost-user driver in the kernel or in userspace.
>>
>> The existing implementation in DPDK/SPDK is a userspace VFIO PCI
>> implementation. The guest kernel in the Device VM does not touch the
>> virtio-vhost-user device.
>>
>> Maybe someone will come up with a use-case where the device emulation
>> needs to happen in the guest kernel (e.g. the in-kernel SCSI target).
>>
>> I think a kernel driver for virtio-vhost-user is not very useful since
>> the actual behavior happens in userspace and involves shared memory.
>> There is already an API for that VFIO. A userspace library would make it
>> nicer to use though.
>>
>> But these are just my thoughts on how the Device VM's software stack
>> should look. This spec allows all approaches.
>>
>> I do think it would be helpful to include an diagram/description in the
>> beginning of the spec with a concrete example of how the Device VM's
>> virtio-vhost-user software stack could look.
>
> Totally agree. Though virtio does not contain diagrams, in this
> particular case, a diagram would really help. Will add one in the next
> revision.
>
>>
>>>> +The driver SHOULD place at least one buffer in rxq before setting the
>>>> +VIRTIO_VHOST_USER_SLAVE_UP bit in the \field{status} configuration
>>>> field.
>>> This is a buffer for use - not an initial message?
>> Yes, an empty buffer. The rxq needs to be populated with buffers so that
>> messages can be received from the master. Vhost-user messages are
>> initiated by the master so the backend does not send an initial message.
>>
>>>> +The following additional resources exist:
>>>> +\begin{description}
>>>> +  \item[Doorbells] The driver signals the vhost-user master through d=
oorbells.  The signal does not carry any data, it is purely an event.
>>>> +  \item[Notifications] The vhost-user master signals the driver for e=
vents besides virtqueue activity and configuration changes by sending notif=
ications.
>>> What is the difference between a doorbell and a notification?
>> Doorbells allow the driver to signal the device (i.e. device hardware
>> registers that the driver writes to).
>>
>> Notifications allow the driver to be signalled by the device (i.e. MSI-X
>> interrupts that the driver handles).
>>
>> The more abstract "doorbell" and "notification" terms are used instead
>> of hardware registers and interrupts because transports other than PCI
>> may want to support these features too.
>
> Let me try to make this a little bit more clear.
>
> A doorbell is a device register that is hooked up to a vhost-user
> callfd.  There is one doorbell for each callfd. When the driver (i.e.,
> the virtio-vhost-user driver) kicks a doorbell, the device (i.e., the
> virtio-vhost-user device) kicks the corresponding callfd. So, doorbells
> are the means for the device emulation software (e.g., the
> vhost-user-net process in the above diagram), running in the Device VM,
> to notify the device driver (e.g., the virtio-net driver in the above
> diagram), running in the Driver VM, for I/O completions.

OK - I think I follow that although it's tricky because a
virtio-vhost-user driver is not like a virtio-device driver - being at
opposite ends of each other. Another good argument for having clear
terminology descriptions. I'll try and come up with some words and a
patch for the spec so we can make it clearer.

> A notification is an interrupt. Notifications are hooked up to
> vhost-user kickds. When a kickfd is kicked by the vhost-user master, the
> virtio-vhost-user device sends the corresponding interrupt to the
> virtio-vhost-user driver. So, notifications are the means for the device
> driver, running in the Driver VM, to notify the device emulation
> software, running in the Device VM, for I/O submissions.

Isn't that the wrong way around, surely a device driver sees a IRQ as
it's notification? Or are we talking about notifications going both ways
here?

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

