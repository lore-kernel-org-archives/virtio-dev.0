Return-Path: virtio-dev-return-7590-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5287F986097
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Jul 2020 11:17:16 +0000 (UTC)
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-2-ndragazis@arrikto.com> <87v9inv26c.fsf@linaro.org>
 <20200717092635.GB128195@stefanha-x1.localdomain>
From: Nikos Dragazis <ndragazis@arrikto.com>
Message-ID: <99b30044-f59c-c9b7-df3a-3a1eb4001042@arrikto.com>
Date: Fri, 17 Jul 2020 14:17:13 +0300
MIME-Version: 1.0
In-Reply-To: <20200717092635.GB128195@stefanha-x1.localdomain>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v5 01/10] vhost-user: add vhost-user device
 type
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 17/7/20 12:26 =CE=BC.=CE=BC., Stefan Hajnoczi wrote:

> On Thu, Jul 16, 2020 at 05:45:47PM +0100, Alex Benn=C3=A9e wrote:
>> Nikos Dragazis <ndragazis@arrikto.com> writes:
>>> diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
>>> new file mode 100644
>>> index 0000000..ac96dc2
>>> --- /dev/null
>>> +++ b/virtio-vhost-user.tex
>>> @@ -0,0 +1,292 @@
>>> +\section{Vhost-user Device Backend}\label{sec:Device Types / Vhost-use=
r Device Backend}
>>> +
>>> +The vhost-user device backend facilitates vhost-user device emulation =
through
>>> +vhost-user protocol exchanges and access to shared memory.  Software-d=
efined
>>> +networking, storage, and other I/O appliances can provide services thr=
ough this
>>> +device.
>>> +
>>> +This section relies on definitions from the \hyperref[intro:Vhost-user
>>> +Protocol]{Vhost-user Protocol}.  Knowledge of the vhost-user protocol =
is a
>>> +prerequisite for understanding this device.
>>> +
>>> +The \hyperref[intro:Vhost-user Protocol]{Vhost-user Protocol} was orig=
inally
>>> +designed for processes on a single system communicating over UNIX doma=
in
>>> +sockets.  The virtio vhost-user device backend allows the vhost-user s=
lave to
>>> +communicate with the vhost-user master over the device instead of a UN=
IX domain
>>> +socket.  This allows the slave and master to run on two separate
>>> systems such
>> I realise we already have the terms master/slave baked into the
>> vhost-user spec but perhaps we could find better wording? The vhost
>> documentation describes thing in terms of who owns the virtqueues (the
>> drive) and who processes the requests (the device). There may be better
>> terminology to use.
> "backend" is now commonly used instead of "slave". There is no new term
> for "master" yet. I suggest replacing "slave" with "backend" in this
> patch.

Makes sense. Some observations:

1. Since "backend" is used instead of "slave", why "frontend" is not
 =C2=A0=C2=A0 used instead of "master"? Also, why does the vhost-user spec =
use the
 =C2=A0=C2=A0 terms"slave" and "backend" interchangeably and doesn't just d=
rop the
 =C2=A0=C2=A0 term"slave"completely?

2. The term "driver" cannot replace the term "master" for one more
 =C2=A0=C2=A0 reason: they refer todifferent things. The master is the hype=
rvisor,
 =C2=A0=C2=A0 not the driver. The driver doesn't even know that the device =
is
 =C2=A0=C2=A0 implemented via the vhost-user mechanism.

>
> Using "device"/"driver" would cause confusion here because
> both virtio-vhost-user itself and the vhost device being emulated
> already use those terms. We need to be able to differentiate between the
> vhost-level master/backend concept and the VIRTIO driver/device concept.
>
>>> +as a virtual machine and a hypervisor.
>> This implies type-2 setups, depending on where you define the
>> hypervisor. Could the language be extended: " or device in one virtual
>> machine with the driver operating in another"?
> Traditional vhost-user looks like this:
>
>         VM
>     virtio-net
>
>         |
>
>        VMM                     vhost-user-net process
> vhost-user master  ------------ vhost-user backend
>
> The vhost-user protocol communication is not visible to the VM. It just
> sees a virtio-net device.
>
> With virtio-vhost-user it looks like this:
>
>      Driver VM                      Device VM
> virtio-net driver             virtio-vhost-user driver
>
>         |                               |
>
>     Driver VMM                      Device VMM
> vhost-user master  ------------ vhost-user backend
>
> Here the master is running on the "hypervisor" (it's the Driver VMM) and
> the backend is running inside the Device VM.
>
> This spec does not require that the Driver VMM and Device VMM
> communicate over the traditional vhost-user UNIX domain socket.
>
> I'm not sure what "device in one virtual machine with the driver
> operating in another" means. The main point of the paragraph is that a
> VIRTIO device for vhost-user allows the master and backend to run on
> separate systems (no longer tied to a UNIX domain socket).
>
> Can you think of a rewording that captures this better?
>
>>> +\begin{description}
>>> +\item[\field{status}] contains the vhost-user operational status.  The=
 default
>>> +    value of this field is 0.
>>> +
>>> +    The driver sets VIRTIO_VHOST_USER_STATUS_SLAVE_UP to indicate read=
iness for
>>> +    the vhost-user master to connect.  The vhost-user master cannot co=
nnect
>>> +    unless the driver has set this bit first.
>> I suspect some deployment diagrams are going to help here. Does this
>> imply that there is something in userspace connected to the slave kernel
>> ready to process messages or just that the driver in the kernel is ready
>> to accept messages?
> That is beyond the scope of the spec. There is no requirement for
> implementing the virtio-vhost-user driver in the kernel or in userspace.
>
> The existing implementation in DPDK/SPDK is a userspace VFIO PCI
> implementation. The guest kernel in the Device VM does not touch the
> virtio-vhost-user device.
>
> Maybe someone will come up with a use-case where the device emulation
> needs to happen in the guest kernel (e.g. the in-kernel SCSI target).
>
> I think a kernel driver for virtio-vhost-user is not very useful since
> the actual behavior happens in userspace and involves shared memory.
> There is already an API for that VFIO. A userspace library would make it
> nicer to use though.
>
> But these are just my thoughts on how the Device VM's software stack
> should look. This spec allows all approaches.
>
> I do think it would be helpful to include an diagram/description in the
> beginning of the spec with a concrete example of how the Device VM's
> virtio-vhost-user software stack could look.

Totally agree. Though virtio does not contain diagrams, in this
particular case, a diagram would really help. Will add one in the next
revision.

>
>>> +The driver SHOULD place at least one buffer in rxq before setting the
>>> +VIRTIO_VHOST_USER_SLAVE_UP bit in the \field{status} configuration
>>> field.
>> This is a buffer for use - not an initial message?
> Yes, an empty buffer. The rxq needs to be populated with buffers so that
> messages can be received from the master. Vhost-user messages are
> initiated by the master so the backend does not send an initial message.
>
>>> +The following additional resources exist:
>>> +\begin{description}
>>> +  \item[Doorbells] The driver signals the vhost-user master through do=
orbells.  The signal does not carry any data, it is purely an event.
>>> +  \item[Notifications] The vhost-user master signals the driver for ev=
ents besides virtqueue activity and configuration changes by sending notifi=
cations.
>> What is the difference between a doorbell and a notification?
> Doorbells allow the driver to signal the device (i.e. device hardware
> registers that the driver writes to).
>
> Notifications allow the driver to be signalled by the device (i.e. MSI-X
> interrupts that the driver handles).
>
> The more abstract "doorbell" and "notification" terms are used instead
> of hardware registers and interrupts because transports other than PCI
> may want to support these features too.

Let me try to make this a little bit more clear.

A doorbell is a device register that is hooked up to a vhost-user
callfd.=C2=A0 There is one doorbell for each callfd. When the driver (i.e.,
the virtio-vhost-user driver) kicks a doorbell, the device (i.e., the
virtio-vhost-user device) kicks the corresponding callfd. So, doorbells
are the means for the device emulation software (e.g., the
vhost-user-net process in the above diagram), running in the Device VM,
to notify the device driver (e.g., the virtio-net driver in the above
diagram), running in the Driver VM, for I/O completions.

A notification is an interrupt. Notifications are hooked up to
vhost-user kickds. When a kickfd is kicked by the vhost-user master, the
virtio-vhost-user device sends the corresponding interrupt to the
virtio-vhost-user driver. So, notifications are the means for the device
driver, running in the Driver VM, to notify the device emulation
software, running in the Device VM, for I/O submissions.

>
>>> +\subsubsection{Doorbell structure layout}\label{sec:Device Types / Vho=
st-user Device Backend / Additional Device Resources over PCI / Doorbell ca=
pability}
>>> +
>>> +The doorbell location is found using the VIRTIO_PCI_CAP_DOORBELL_CFG
>>> +capability.  This capability is immediately followed by an additional
>>> +field, like so:
>>> +
>>> +\begin{lstlisting}
>>> +struct virtio_pci_doorbell_cap {
>>> +        struct virtio_pci_cap cap;
>>> +        le32 doorbell_off_multiplier;
>>> +};
>>> +\end{lstlisting}
>> OK stuff is disappearing in later patches. Maybe it shouldn't be
>> introduced in the first place?
> I think Nikos sent the patches in this order to keep my authorship.

That's right.

>
> Nikos: Feel free to squash everything into one patch and add your
> Signed-off-by. You can also set yourself as the author of the git
> commit. As long as my Signed-off-by stays on the patch it indicates I
> have given permission to use this text.

OK. Will do.

>
> Stefan

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

