Return-Path: <virtio-dev-return-10958-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7509E98634C
	for <virtio-dev@lists.oasis-open.org>; Mon, 13 Feb 2023 12:06:39 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <m24jru3my1.fsf@oracle.com>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-2-mst@redhat.com> <m24jru3my1.fsf@oracle.com>
Date: Mon, 13 Feb 2023 13:06:32 +0100
Message-ID: <87edqtdb1z.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] [PATCH v10 01/10] virtio:
 document forward compatibility guarantees
Content-Type: text/plain
To: David Edmondson <david.edmondson@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, jasowang@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 09 2023, David Edmondson <david.edmondson@oracle.com> wrote:

> On Thursday, 2023-02-09 at 07:13:32 -05, Michael S. Tsirkin wrote:
>> +In particular, this is
>> +especially important for features limited to specific transports,
>> +as enabling these for more transports in future versions of the
>> +specification is highly likely to require changing the behaviour
>> +from drivers and devices.  Drivers and devices supporting
>
> "changing the behaviour of" or "changed behaviour from" (prefer the
> former).

Agreed, I'd prefer the former as well.

>
>> +multiple transports need to carefully maintain per-transport
>> +lists of allowed features.
>> +
>>  \drivernormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio Device / Feature Bits}
>>  The driver MUST NOT accept a feature which the device did not offer,
>>  and MUST NOT accept a feature which requires another feature which was
>>  not accepted.
>>  
>> +The driver MUST validate the feature bits offered by the device.
>> +The driver MUST ignore and MUST NOT accept any feature bit that is
>> +\begin{itemize}
>> +\item not described in this specification,
>> +\item marked as reserved,
>> +\item not supported for the specific transport,
>
> What does "supported" mean here? By the driver? By the specification in
> respect of this transport?

Maybe "not specified for the specific transport"?

>
>> +\item not defined for the device type.
>> +\end{itemize}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

