Return-Path: <virtio-dev-return-9515-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6239E98634A
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 May 2022 12:13:52 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220502113914.20119-1-mst@redhat.com>
References: <20220502113914.20119-1-mst@redhat.com>
Date: Mon, 02 May 2022 14:13:43 +0200
Message-ID: <874k286sjs.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [virtio] [PATCH] acknowledgements: update for 1.2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, May 02 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> To keep things simple I decided to just move the previous content
> to a historical acknowledgements section and add a new one.

Yes, that makes sense.

Btw: do we update the affiliations of people who moved employers in the
meantime? Or do we reflect the state at the time they contributed?

>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
>
>  acknowledgements.tex | 75 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 74 insertions(+), 1 deletion(-)
>
> diff --git a/acknowledgements.tex b/acknowledgements.tex
> index 4520cd3..1c0a155 100644
> --- a/acknowledgements.tex
> +++ b/acknowledgements.tex
> @@ -5,6 +5,78 @@ \chapter{Acknowledgements}\label{chap:Acknowledgements}
> =20
>  The following individuals have participated in the creation of this spec=
ification and are gratefully acknowledged:
> =20
> +\subsection*{Participants}
> +Alexander Duyck, Intel \newline
> +Alex Benn=C3=A9e, Linaro \newline
> +Anton Yakovlev, OpenSynergy \newline
> +Arseny Krasnov, Kaspersky Lab \newline
> +Cornelia Huck, Red Hat \newline
> +David Hildenbrand, Red Hat \newline
> +David Stevens, Chromium \newline
> +Dr. David Alan Gilbert, Red Hat \newline
> +Enrico Granata, Google \newline
> +Eugenio P=C3=A9rez, Red Hat \newline
> +Felipe Franciosi, Nutanix \newline
> +Gaetan Harter, OpenSynergy \newline
> +Gerd Hoffmann, Red Hat \newline
> +Gurchetan Singh, Chromium \newline
> +Halil Pasic, IBM \newline
> +Hao Chen, Google \newline
> +Huang Yang, Intel \newline
> +Jan Kiszka, Siemens \newline
> +Jean-Philippe Brucker, Linaro \newline
> +Jiang Wang, Bytedance \newline
> +Jie Deng, Intel \newline
> +Joel Nider, Individual \newline
> +Johannes Berg, Intel \newline
> +Junji Wei, Bytedance \newline
> +Keiichi Watanabe, Chromium \newline
> +Marcel Holtmann, Individual \newline
> +Max Gurtovoy, Nvidia \newline
> +Michael S. Tsirkin, Red Hat \newline
> +Nikos Dragazis, Arrikto \newline
> +Pankaj Gupta, Red Hat \newline
> +Paolo Bonzini, Red Hat \newline
> +Parav Pandit, Nvidia \newline
> +Peter Hilber, OpenSynergy \newline
> +Petre Eftime, Amazon \newline
> +Philipp Hahn, Univention \newline
> +Rob Bradford, Intel \newline
> +Stefan Fritsch, Individual \newline
> +Stefan Hajnoczi, Red Hat \newline
> +Stefano Garzarella, Red Hat \newline
> +Taylor Stark, Microsoft \newline
> +Tiwei Bie, Intel \newline
> +Viresh Kumar, Linaro \newline
> +Vitaly Mireyno, Marvell \newline
> +Xuan Zhuo, Alibaba \newline
> +Yadong Qi, Intel \newline
> +Yoni Bettan, Red Hat \newline
> +Yuri Benditovich, Red Hat / Daynix \newline
> +
> +The following non-members have provided valuable feedback on this
> +specification and are gratefully acknowledged:
> +
> +\subsection*{Reviewers}
> +Christophe de Dinechin, Red Hat \newline
> +Gil Savir, Intel \newline
> +Ruchika Gupta, Linaro \newline
> +Arnd Bergmann, Individual \newline
> +Bing Zhu, Intel \newline
> +Eduardo Habkost, Red Hat \newline
> +Eric Auger, Red Hat \newline
> +Jason Wang, Red Hat \newline
> +Jens Freimann, Red Hat \newline
> +Kevin Tian, Intel \newline
> +Linus Walleij, Linaro \newline
> +Matti M=C3=B6ll, OpenSynergy \newline
> +Tomas Winkler, Intel \newline
> +Yang Huang, Intel \newline
> +
> +
> +The following individuals have participated in the creation of
> +previous versions of this specification and are gratefully acknowledged:
> +
>  \subsection*{Participants}
>  Allen Chia, Oracle=09\newline
>  Amit Shah,=09Red Hat=09\newline
> @@ -59,7 +131,8 @@ \subsection*{Participants}
>  Wei Wang, Intel=09\newline
>  Xin Zeng, Intel=09\newline
> =20
> -The following non-members have provided valuable feedback on this
> +The following non-members have provided valuable feedback on
> +previous versions of this
>  specification and are gratefully acknowledged:
> =20
>  \subsection*{Reviewers}
> --=20
> MST
>
>
> ---------------------------------------------------------------------
> To unsubscribe from this mail list, you must leave the OASIS TC that=20
> generates this mail.  Follow this link to all your TCs in OASIS at:
> https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

