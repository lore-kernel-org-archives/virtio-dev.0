Return-Path: <virtio-dev-return-11259-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 91159986675
	for <virtio-dev@lists.oasis-open.org>; Fri, 24 Feb 2023 18:20:58 +0000 (UTC)
References: <d9beee5f7b4a4acdb5f5eff8af55bed50b33d722.1676971686.git.viresh.kumar@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 24 Feb 2023 18:20:31 +0000
In-reply-to: <d9beee5f7b4a4acdb5f5eff8af55bed50b33d722.1676971686.git.viresh.kumar@linaro.org>
Message-ID: <878rgmorg8.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [RFC QEMU] docs: vhost-user: Add custom memory mapping support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, stratos-dev@op-lists.linaro.org, Oleksandr Tyshchenko <olekstysh@gmail.com>, xen-devel@lists.xen.org, Andrew Cooper <andrew.cooper3@citrix.com>, Juergen Gross <jgross@suse.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Liu Jiang <gerry@linux.alibaba.com>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>


Viresh Kumar <viresh.kumar@linaro.org> writes:

> The current model of memory mapping at the back-end works fine with
> Qemu, where a standard call to mmap() for the respective file
> descriptor, passed from front-end, is generally all we need to do before
> the front-end can start accessing the guest memory.
>
> There are other complex cases though, where we need more information at
> the backend and need to do more than just an mmap() call. For example,
> Xen, a type-1 hypervisor, currently supports memory mapping via two
> different methods, foreign-mapping (via /dev/privcmd) and grant-dev (via
> /dev/gntdev). In both these cases, the back-end needs to call mmap()
> followed by an ioctl() (or vice-versa), and need to pass extra
> information via the ioctl(), like the Xen domain-id of the guest whose
> memory we are trying to map.
>
> Add a new protocol feature, 'VHOST_USER_PROTOCOL_F_CUSTOM_MMAP', which
> lets the back-end know about the additional memory mapping requirements.
> When this feature is negotiated, the front-end can send the
> 'VHOST_USER_CUSTOM_MMAP' message type to provide the additional
> information to the back-end.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  docs/interop/vhost-user.rst | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 3f18ab424eb0..f2b1d705593a 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -258,6 +258,23 @@ Inflight description
> =20
>  :queue size: a 16-bit size of virtqueues
> =20
> +Custom mmap description
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> ++-------+-------+
> +| flags | value |
> ++-------+-------+
> +
> +:flags: 64-bit bit field
> +
> +- Bit 0 is Xen foreign memory access flag - needs Xen foreign memory map=
ping.
> +- Bit 1 is Xen grant memory access flag - needs Xen grant memory mapping=
.
> +
> +:value: a 64-bit hypervisor specific value.
> +
> +- For Xen foreign or grant memory access, this is set with guest's xen d=
omain
> +  id.
> +
>  C structure
>  -----------
> =20
> @@ -867,6 +884,7 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
>    #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>    #define VHOST_USER_PROTOCOL_F_STATUS               16
> +  #define VHOST_USER_PROTOCOL_F_CUSTOM_MMAP          17
> =20
>  Front-end message types
>  -----------------------
> @@ -1422,6 +1440,20 @@ Front-end message types
>    query the back-end for its device status as defined in the Virtio
>    specification.
> =20
> +``VHOST_USER_CUSTOM_MMAP``
> +  :id: 41
> +  :equivalent ioctl: N/A
> +  :request payload: Custom mmap description
> +  :reply payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_CUSTOM_MMAP`` protocol feature has be=
en
> +  successfully negotiated, this message is submitted by the front-end to
> +  notify the back-end of the special memory mapping requirements, that t=
he
> +  back-end needs to take care of, while mapping any memory regions sent
> +  over by the front-end. The front-end must send this message before
> +  any memory-regions are sent to the back-end via ``VHOST_USER_SET_MEM_T=
ABLE``
> +  or ``VHOST_USER_ADD_MEM_REG`` message types.
> +
> =20
>  Back-end message types
>  ----------------------

This looks good enough for me. We will see how it works in prototype.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

