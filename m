Return-Path: <virtio-dev-return-9379-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 20D9A986231
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Apr 2022 10:27:29 +0000 (UTC)
Date: Mon, 4 Apr 2022 11:27:15 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YkrIAz5R79Tsl7bv@stefanha-x1.localdomain>
References: <20220330152659.3780600-1-usama.arif@bytedance.com>
 <20220330152659.3780600-3-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cQhB3l19GUcSM3z5"
Content-Disposition: inline
In-Reply-To: <20220330152659.3780600-3-usama.arif@bytedance.com>
Subject: [virtio-dev] Re: [PATCH 2/4] content: Introduce driver/device aux. notification
 cfg type for PCI
To: Usama Arif <usama.arif@bytedance.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com
List-ID: <virtio-dev.lists.oasis-open.org>

--cQhB3l19GUcSM3z5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 30, 2022 at 04:26:57PM +0100, Usama Arif wrote:
> +The \field{cap.offset} and \field{dev_aux_notification_off_multiplier} are taken
> +from the device auxiliary notification capability structure above, and the
> +\field{dev_aux_notification_idx} is the device auxiliary notification index. There is no restriction for
> +the mapping between device auxiliary notifications and dev_aux_notification_idx. The mapping is
> +device-specific. One possible mapping would be to use the integers 0 to
> +N-1 as the device auxiliary notification indices for a total of N device auxiliary notifications.
> +The total number of device auxiliary notifications exposed by the device is also device-specific.

The second half of the paragraph could be shortened to "The number of
device auxiliary notifications and their purpose is device-specific". I
don't think discussing the device-specific mapping and that it may be
0 to N-1 or something else adds anything.

> +
> +\devicenormative{\paragraph}{Device auxiliary notification capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Device auxiliary notification capability}
> +
> +The \field{cap.offset} MUST be 2-byte aligned.
> +
> +The device MUST either present \field{dev_aux_notification_off_multiplier} as an
> +even power of 2, or present \field{dev_aux_notification_off_multiplier} as 0.
> +
> +The value \field{cap.length} presented by the device MUST be at least 2
> +and MUST be large enough to support device auxiliary notification offsets for all supported
> +device auxiliary notifications in all possible configurations.
> +
> +The value \field{cap.length} presented by the device MUST satisfy:
> +
> +\begin{lstlisting}
> +cap.length >= max_dev_aux_notification_idx * dev_aux_notification_off_multiplier + 2
> +\end{lstlisting}
> +
> +where \field{max_dev_aux_notification_idx} is the maximum device auxiliary notification index and is
> +dependent on the device.

One thought about dev aux notifications: the size is limited to 2 bytes.
Sometimes it's useful to communicate information (i.e. 1, 2, or 4 bytes)
as part of the notification (virtio-vhost-user may not need it but other
users might). Perhaps the width should be device-specific and not fixed
to 2?

> +
> +\subsubsection{Driver auxiliary notification capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Driver auxiliary notification capability}
> +
> +The Driver auxiliary notification
> +\ref{sec:Basic Facilities of a Virtio Device / Notifications} location
> +is found using the VIRTIO_PCI_CAP_DRIVER_AUX_NOTIFY_CFG capability. The
> +driver auxiliary notification structure allows MSI-X vectors to be
> +configured for notification interrupts. If MSI-X is not available, bit 2
> +of the ISR status \ref{sec:Virtio Transport Options / Virtio Over PCI
> +Bus / PCI Device Layout / ISR status capability} indicates that a
> +driver auxiliary notification occurred.

Is there any way to determine which driver auxiliary notification
occurred when MSI-X is not available? Please make this clear in the
text.

> +
> +The driver auxiliary notification structure is the following:
> +
> +\begin{lstlisting}
> +struct virtio_pci_driver_aux_notification_cfg {
> +	le16 driver_aux_notification_select;              /* read-write */
> +	le16 driver_aux_notification_msix_vector;         /* read-write */
> +};
> +\end{lstlisting}
> +
> +The driver indicates which notification is of interest by writing the
> +\field{driver_aux_notification_select} field. The driver then writes the MSI-X
> +vector or VIRTIO_MSI_NO_VECTOR to \field{driver_aux_notification_msix_vector} to
> +change the MSI-X vector for that notification.
> +
> +The mapping between notifications and notification indices is
> +device-specific. The total number of notifications is also
> +device-specific.
> +
> +\devicenormative{\paragraph}{Driver auxiliary notification capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Driver auxiliary notification capability}
> +
> +Device MUST ignore writes to \field{driver_aux_notification_msix_vector} if the
> +value written to \field{driver_aux_notification_select} is not a valid notification
> +index.
> +
> +Device MUST return VIRTIO_MSI_NO_VECTOR for reads from
> +\field{driver_aux_notification_msix_vector} if the value written to
> +\field{driver_aux_notification_select} is not a valid notification index.

Maybe the spec should say something about the minimum number of MSI-X
vectors presented by the device?

  num_vectors >= 1 /* config change */ + num_vqs + num_driver_aux_notifications

--cQhB3l19GUcSM3z5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJKyAMACgkQnKSrs4Gr
c8j9aggAkkYUjKD1x/6JIyeOmJV5pgjnVdfDCV4UYkWRie8yrv53JdoZg0LKbpDE
FL9s/9SrvzUsS/jhtqvffkfpIRUJClRaIvEaJvY9/Ni+e/AANNud1N565Lp47a03
cWO7lwgoEr98/ERHuDeHysHZ+FjqA16P3dGsx5PIvRFppKR/qYhZaXwSNSvZ8XRf
cN22LP0KXORg6HHjqNSpz1qcNs227l/EmE5Fe58IMfq8KVwcqn2FgHxINCrwdZE3
TILheKMytYVuCyMzGuEiuLsBDS5oiweWkfW0y/dGHCmfJ9fGdZcynCLItjq/z1De
eVuD3EVAPldP94Nv3nq1Nx2S11/LOw==
=OVdP
-----END PGP SIGNATURE-----

--cQhB3l19GUcSM3z5--

