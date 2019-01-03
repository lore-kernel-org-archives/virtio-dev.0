Return-Path: virtio-dev-return-5235-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6564A985AFA
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Jan 2019 10:26:18 +0000 (UTC)
Message-ID: <5C2DE48D.4090105@intel.com>
Date: Thu, 03 Jan 2019 18:31:41 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>        <1546493462-32244-2-git-send-email-wei.w.wang@intel.com> <20190103104018.33eeaa29.cohuck@redhat.com>
In-Reply-To: <20190103104018.33eeaa29.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v1 1/2] virtio-balloon: tweak config_changed implementation
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 01/03/2019 05:40 PM, Cornelia Huck wrote:
> On Thu,  3 Jan 2019 13:31:01 +0800
> Wei Wang <wei.w.wang@intel.com> wrote:
>
>> virtio-ccw has deadlock issues with reading config registers inside the
> s/config registers/the config space/ ?

Sounds good.

>
>> interrupt context, so we tweak the virtballoon_changed implementation
>> by moving the config read operations into the related workqueue contexts.
> Also credit Christian with a Reported-by:?

Yes, definitely. Sorry for missing that.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

