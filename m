Return-Path: virtio-dev-return-3645-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2990C1CB8078
	for <virtio-dev@lists.oasis-open.org>; Mon, 26 Mar 2018 03:55:25 -0700 (PDT)
Message-ID: <5AB8D24F.8020304@intel.com>
Date: Mon, 26 Mar 2018 18:58:23 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1521197309-13544-1-git-send-email-wei.w.wang@intel.com> <1521197309-13544-5-git-send-email-wei.w.wang@intel.com> <20180316165319-mutt-send-email-mst@kernel.org> <5AAE4124.5010602@intel.com> <20180319062023-mutt-send-email-mst@kernel.org> <5AAF7C72.5070403@intel.com> <20180320004900-mutt-send-email-mst@kernel.org> <5AB06EE9.1030306@intel.com> <20180320045134-mutt-send-email-mst@kernel.org> <5AB07D7F.90205@intel.com> <20180320051840-mutt-send-email-mst@kernel.org> <5AB31F68.8000605@intel.com>
In-Reply-To: <5AB31F68.8000605@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH v5 4/5] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 03/22/2018 11:13 AM, Wei Wang wrote:
>
> OK. I've tried to implement it this way: create an iothread via the 
> qemu cmdline option: --device 
> virtio-balloon,free-page-hint=true,iothread=iothread10, and schedule a 
> BH to run in the iothread context when free_page_start() is called.
>
> I think the drawback of this method is that the iothread exists during 
> the whole QEMU lifetime, which wastes CPU cycles (e.g. when live 
> migration isn't in progress). The method in v5 is like migration 
> thread, which comes only when the migration request is received and 
> goes when migration is done. Any thought?
>

Hi Michael,

Would it be acceptable to go with the thread creation method for now? I 
would prefer that method for the above reasons. If you are very 
confident about the iothread method, I can also send out the patches 
with that implementation. Hope we could finish this feature soon. Thanks.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

