Return-Path: virtio-dev-return-7303-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1C7F2985CE6
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 May 2020 09:40:34 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Mon, 11 May 2020 11:40:22 +0200
Message-ID: <2405792.XL1faGB9W5@os-lin-dmo>
In-Reply-To: <CAK25hWOPS1wGORXgtv8hUNu9-mLO+5C_k3Cj=8pnoFWmjuhJdg@mail.gmail.com>
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com> <CAK25hWMj5PyQFZVN5AToHjdySvi6iZ4zjZeUJQR85jNgoeLeAw@mail.gmail.com> <CAK25hWOPS1wGORXgtv8hUNu9-mLO+5C_k3Cj=8pnoFWmjuhJdg@mail.gmail.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: Fwd: Qemu Support for Virtio Video V4L2 driver
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: Kiran Pawar <Kiran.Pawar@opensynergy.com>, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, qemu-devel@nongnu.org, Saket Sinha <saket.sinha89@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Saket and all,

As we are working with automotive platforms, unfortunately we don't plan any 
Qemu reference implementation so far.

Of course we are ready to support the community if any help is needed. Is 
there interest in support for the FWHT format only for testing purpose or you 
want a full-featured implementation on the QEMU side?

Please note that the spec is not finalized yet and a major update is now 
discussed with upstream and the Chrome OS team, which is also interested and 
deeply involved in the process. The update mostly implies some rewording and 
reorganization of data structures, but for sure will require a driver rework.

Best regards,
Dmitry.

On Samstag, 9. Mai 2020 16:11:43 CEST Saket Sinha wrote:
> Hi,
> 
> As suggested on #qemu-devel IRC channel, I am including virtio-dev, Gerd and
> Michael to point in the right direction how to move forward with Qemu
> support for Virtio Video V4L2 driver
> posted in [1].
> 
> [1]: https://patchwork.linuxtv.org/patch/61717/
> 
> Regards,
> Saket Sinha
> 
> On Sat, May 9, 2020 at 1:09 AM Saket Sinha <saket.sinha89@gmail.com> wrote:
> > Hi ,
> > 
> > This is to inquire about Qemu support for Virtio Video V4L2 driver
> > posted in [1].
> > I am currently not aware of any upstream effort for Qemu reference
> > implementation and would like to discuss how to proceed with the same.
> > 
> > [1]: https://patchwork.linuxtv.org/patch/61717/
> > 
> > Regards,
> > Saket Sinha



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

