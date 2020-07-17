Return-Path: virtio-dev-return-7591-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E70C698609F
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Jul 2020 15:00:11 +0000 (UTC)
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-5-ndragazis@arrikto.com>
 <20200717093649.GE128195@stefanha-x1.localdomain>
From: Nikos Dragazis <ndragazis@arrikto.com>
Message-ID: <0d7522d9-9b9b-66ee-b0ee-bc03ad604510@arrikto.com>
Date: Fri, 17 Jul 2020 18:00:09 +0300
MIME-Version: 1.0
In-Reply-To: <20200717093649.GE128195@stefanha-x1.localdomain>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v5 04/10] vhost-user: update shared memory
 capability
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 17/7/20 12:36 =CE=BC.=CE=BC., Stefan Hajnoczi wrote:

> On Mon, May 18, 2020 at 11:37:15PM +0300, Nikos Dragazis wrote:
>> The virtio vhost-user device has shared memory resources. Therefore, it
>> uses the VIRTIO_PCI_CAP_SHARED_MEMORY_CFG capability to standardize
>> those resources through the PCI Configuration Space. This patch
>> synchronizes the virtio vhost-user device spec with the following shared
>> memory resources PATCH:
>>
>> https://lists.oasis-open.org/archives/virtio-dev/201902/msg00142.html
>>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
>> ---
>>   virtio-vhost-user.tex | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
>> index 7a8cd9c..d1305dd 100644
>> --- a/virtio-vhost-user.tex
>> +++ b/virtio-vhost-user.tex
>> @@ -320,7 +320,22 @@ \subsubsection{Notification structure layout}\label=
{sec:Device Types / Vhost-use
>>   \subsubsection{Shared memory capability}\label{sec:Device Types / Vhos=
t-user Device Backend / Additional Device Resources over PCI / Shared Memor=
y capability}
>>  =20
>>   The shared memory location is found using the VIRTIO_PCI_CAP_SHARED_ME=
MORY_CFG
> Now that Shared Memory Resources are part of the VIRTIO device model the
> virtio-vhost-user spec should not refer to PCI-specific details anymore.
> It should just explain which Shared Memory Resources are available on
> the device. The mapping to PCI is already covered in the VIRTIO PCI
> transport spec section.

Right. Actually, I have removed the PCI-specific details in the commit
08/10. I see that having non-incremental commits creates confusion, so
I will not be doing this anymore.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

