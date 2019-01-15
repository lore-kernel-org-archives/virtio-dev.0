Return-Path: virtio-dev-return-5329-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B54EE9849F6
	for <virtio-dev@lists.oasis-open.org>; Tue, 15 Jan 2019 02:13:27 +0000 (UTC)
Message-ID: <5C3D4313.7090306@intel.com>
Date: Tue, 15 Jan 2019 10:18:59 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com> <1546844466-38079-3-git-send-email-wei.w.wang@intel.com> <20190114195450-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190114195450-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v3 2/3] virtio-balloon: improve update_balloon_size_func
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 01/15/2019 09:00 AM, Michael S. Tsirkin wrote:
> On Mon, Jan 07, 2019 at 03:01:05PM +0800, Wei Wang wrote:
>> There is no need to update the balloon actual register when there is no
>> ballooning request. This patch avoids update_balloon_size when diff is 0.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> It sounds reasonable but it does have a side effect of
> not writing into actual anymore.
>
> I am not sure actual never can get out of sync as a result.
>
> So better deferred, pls send this in the next merge window.
>

No problem, it's not urgent to me.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

