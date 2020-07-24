Return-Path: virtio-dev-return-7616-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E079B985E71
	for <virtio-dev@lists.oasis-open.org>; Fri, 24 Jul 2020 13:41:25 +0000 (UTC)
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-9-ndragazis@arrikto.com>
 <20200717094807.GH128195@stefanha-x1.localdomain>
 <d6fa9520-82f7-ed73-f991-f91b70f712ca@arrikto.com>
 <20200723062940.GC268427@stefanha-x1.localdomain>
From: Nikos Dragazis <ndragazis@arrikto.com>
Message-ID: <3ba315e9-61e1-3b0c-3952-c408e156ea8a@arrikto.com>
Date: Fri, 24 Jul 2020 16:41:23 +0300
MIME-Version: 1.0
In-Reply-To: <20200723062940.GC268427@stefanha-x1.localdomain>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v5 08/10] vhost-user: remove the extra PCI
 capabilities
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 23/7/20 9:29 =CF=80.=CE=BC., Stefan Hajnoczi wrote:

> On Fri, Jul 17, 2020 at 06:03:57PM +0300, Nikos Dragazis wrote:
>> On 17/7/20 12:48 =CE=BC.=CE=BC., Stefan Hajnoczi wrote:
>>
>>> On Mon, May 18, 2020 at 11:37:19PM +0300, Nikos Dragazis wrote:
>>>> -Additional resources are configured on the virtio PCI transport by th=
e following \field{struct virtio_pci_cap.cfg_type} values:
>>>> +\subsubsection{Doorbell layout}\label{sec:Device Types / Vhost-user D=
evice Backend / Additional Device Resources / Doorbell layout}
>>>> -\begin{lstlisting}
>>>> -#define VIRTIO_PCI_CAP_DOORBELL_CFG 6
>>>> -#define VIRTIO_PCI_CAP_NOTIFICATION_CFG 7
>>>> -#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
>>>> -\end{lstlisting}
>>>> +The device MUST reserve 2N+1 virtqueue indices that can be used by th=
e driver to
>>>> +send doorbell notifications. The driver can use these indices to send=
 doorbell
>>>> +notifications in the same way that it sends available buffer notifica=
tions
>>>> +\ref{sec:Basic Facilities of a Virtio Device / Notifications} for a v=
irtqueue.
>>> Notifications and doorbells should be first-class VIRTIO device model
>>> concepts, like Shared Memory resources. It should not be necessary to
>>> reserve dummy virtqueues (a hack for getting MSI-X vectors and doorbell
>>> registers).
>> Well, it's not exactly equivalent to the shared memory resource
>> because, in case of doorbells and notifications, the functionality is
>> already there. But I see your point. It is a design issue. We could
>> definitely standardize the doorbell and notification resources, but I
>> don't see why this solution is preferable. Do you have something in
>> mind?
> Yes, there are advantages to defining doorbells and notifications as
> separate concepts:
>
>   * Doorbells and notifications may be implemented differently from
>     virtqueue notifications on some the transports.
>   * Virtqueues may consume more resources on some transports.
>   * Existing drivers may have issues distinguishing between normal
>     virtqueues and dummy virtqueues.
>
> Overall I think using dummy virtqueues is a hacky approach. It's
> something that would be necessary if we couldn't extend the core VIRTIO
> device model. Since we do have the opportunity of extending the core
> VIRTIO device model cleanly I think doing so will avoid headaches later.
>
> Stefan

OK. Let's standardize them. I will send a separate patch for this. I
can't think of all the details right now, so, I'll come back if anything
troubles me.

Nikos

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

