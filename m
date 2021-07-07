Return-Path: <virtio-dev-return-8243-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4BE01986444
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Jul 2021 03:29:30 +0000 (UTC)
References: <20210706043334.36359-1-jasowang@redhat.com>
 <20210706043334.36359-2-jasowang@redhat.com> <87h7h7hbjl.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d85957ba-77d2-22cb-eca0-08e46f23532a@redhat.com>
Date: Wed, 7 Jul 2021 11:29:17 +0800
MIME-Version: 1.0
In-Reply-To: <87h7h7hbjl.fsf@redhat.com>
Subject: [virtio-dev] Re: [PATCH V2 1/2] virtio: introduce virtqueue state as basic
 facility
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, mst@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: stefanha@redhat.com, mgurtovoy@nvidia.com, eperezma@redhat.com, oren@nvidia.com, shahafs@nvidia.com, parav@nvidia.com, bodong@nvidia.com, amikheev@nvidia.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>


=D4=DA 2021/7/6 =CF=C2=CE=E78:27, Cornelia Huck =D0=B4=B5=C0:
> On Tue, Jul 06 2021, Jason Wang <jasowang@redhat.com> wrote:
>
>> This patch adds new device facility to save and restore virtqueue
>> state. The virtqueue state is split into two parts:
>>
>> - The available state: The state that is used for read the next
>>    available buffer.
>> - The used state: The state that is used for making buffer used.
>>
>> Note that, there could be devices that is required to set and get the
>> requests that are being processed by the device. I leave such API to
>> be device specific.
>>
>> This facility could be used by both migration and device diagnostic.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   content.tex | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 117 insertions(+)
>> +\devicenormative{\subsection}{Virtqueue State}{Basic Facilities of a Vi=
rtio Device / Virtqueue State}
>> +
>> +If VIRTIO_F_RING_STATE has not been negotiated, a device MUST ingore
>> +the read and write to the virtqueue state.
>> +
>> +If VIRTIO_F_RING_STATE has been negotiated:
>> +\begin{itemize}
>> +\item A device SHOULD ignore the write to the virtqueue state if the
>> +FEATURE_OK status bit is not set.
>> +\item A device SHOULD ignore the write to the virtqueue state if the
>> +DRIVER_OK status bit is set.
>> +\end{itemize}
>> +
>> +If VIRTIO_F_RING_STATE has been negotiated, a device MAY has its
>> +device-specific way for the driver to set and get extra virtqueue
>> +states such as in flight requests.
> Maybe better
>
> "If VIRTIO_F_RING_STATE has been negotiated, a device MAY provide a
> device-specific mechanism to set and get extra virtqueue states such as
> in flight reqeuests."
>
> If a device type supports this facility, does it imply that it is always
> present when VIRTIO_RING_STATE has been negotiated?


It's not, it's device specific.


> I guess it could
> define further device-specific features to make it more configurable.


Yes, I can clarify this in the next version.

Thanks


>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

