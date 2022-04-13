Return-Path: <virtio-return-3683-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220125122332.64473-1-mst@redhat.com>
References: <20220125122332.64473-1-mst@redhat.com>
Date: Wed, 13 Apr 2022 11:35:50 +0200
Message-ID: <87lew99vgp.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio] Re: [virtio-dev] [PATCH] virtio-gpio: offered -> negotiated
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> virtqueues are only discovered after FEATURES_OK.
> As such it makes no sense to talk about virtqueues being affected by
> features which are offered but not negotiated, and doing so will confuse
> the reader.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Viresh, others your thoughts on this? Looks like an obvious typo
> to me, and something that I think we can fix under the editorial
> changes rule.
>
>  virtio-gpio.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Pushed as editorial update.


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

