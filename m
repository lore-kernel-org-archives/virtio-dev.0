Return-Path: virtio-dev-return-4931-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6801F985C2E
	for <virtio-dev@lists.oasis-open.org>; Wed, 31 Oct 2018 15:51:46 +0000 (UTC)
Date: Wed, 31 Oct 2018 16:51:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181031165138.773c263d.cohuck@redhat.com>
In-Reply-To: <1540999089-27821-1-git-send-email-danielm@mellanox.com>
References: <1540999089-27821-1-git-send-email-danielm@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH v2 0/2] Typos, grammar and cosmetic fixes
To: Daniel Marcovitch <danielm@mellanox.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 31 Oct 2018 17:18:09 +0200
Daniel Marcovitch <danielm@mellanox.com> wrote:

> v2 - includes the fixes suggested by Cornelia + Stefan
> 
> Daniel Marcovitch (2):
>   packed-ring/split-ring/content: fixed misc typos
>   queue_size: renamed "hypervisor" to "device"
> 
>  content.tex     | 4 ++--
>  packed-ring.tex | 2 +-
>  split-ring.tex  | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 

Looks good to me. (But somehow, threading seems broken with your v2 --
your v1 was fine.)

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

