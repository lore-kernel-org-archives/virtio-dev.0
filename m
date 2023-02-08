Return-Path: <virtio-dev-return-10787-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Message-ID: <a20442cc-3c92-7cd7-8e14-0ae4c09b19cf@linux.alibaba.com>
Date: Wed, 8 Feb 2023 19:24:53 +0800
MIME-Version: 1.0
References: <20230207111634.75542-1-hengqi@linux.alibaba.com>
 <20230207090019-mutt-send-email-mst@kernel.org>
 <98c2cd3f-2f59-74e1-0b37-cbf2a9180bd4@linux.alibaba.com>
 <20230208050822-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230208050822-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [virtio-comment] [PATCH] virtio-net: support
 per-queue coalescing moderation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/8 =E4=B8=8B=E5=8D=886:10, Michael S. Tsirkin =E5=86=99=E9=
=81=93:
> On Wed, Feb 08, 2023 at 09:57:54AM +0800, Heng Qi wrote:
>>> I think it's a good idea to do this on top of Alvaro's patch
>>> unifying these two structures.
>> I saw Alvaro's patch, but it doesn't seem to be stable yet, is there a g=
ood
>> way for me to
>> unify the two structures, since a patch should only do one thing.
> Problem is you were trying to change these existing structures too
> so the patches conflicted. However I think at this point
> we are in agreement on a new command with a new structure.
> In this case there won't be a conflict as you are
> not touching existing commands so no need for you
> to depend on Alvaro's patch.

I get it.

Thanks.

>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

