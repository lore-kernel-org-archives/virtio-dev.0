Return-Path: <virtio-dev-return-11584-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A26C61DA4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 17:16:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E027C2AC53
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 17:16:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D146A98670A
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 17:16:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C556E9866FD; Thu,  9 Mar 2023 17:16:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B30A59866FC;
	Thu,  9 Mar 2023 17:16:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqGf/umfqrEI/fNsaU4atLnWZEEe0q+zgDpTsyC7QQEusDfkUzCouwVK5PNpJRIjiiaxcp0lyLkoLdP9csvfXYW/0VZn2Hl3HtL3agAzjrHeEtc0N8+RiwUU5s1gyoPI4KprdmsdBGhqYPVSydhbfJJVMEHnQvYUZnd+2ebX40pMaHkDm/0icCVxZK2zYqWwODkK7vHXKkhMSXFlHRUSTqlKZszdMOLwHXgUSl5PHdIwE42PGZPQyRHfpvpenq6NzS2uAsfuPPhbq8SCX8kFvgIqGKuUrv0W8jYLfJq2hMZ46/Vjrd6rsTIxDv0wphmT7SRLobZTbSTmfNCnsqJpmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYbQlWtMfZUmBvSLOaRYxCUcyBJrIbKLmMEj0Gmfgo0=;
 b=WnwTQla6nzHDrc8gfZqT+wYMIeSzTvD1CedanVk+92AedeaivihISOuIRkEKdFsS8LLpcRFLrtjZVkVN9c/kIv3gK3AmseTx4oY1GsIsZR34WKtplgxoN4rNvewXzyw+N4iMfX9y2p9cnhf6EbbGwIZHcD5JlHXdlP9su4NmOqBOpH1RG4qB8zYKPFEirovlUnMXH3UWSWq0TeAl3iZ9raFGSGpe4vphriBcF2iqpr88RfXv9MWm2GAwGRf4Rt2l3M+h13Ueeuh7Q6yHNqaDuYsu8NTn6QpoJUOwI5AHsw4qFsTx1rjHZQDaTq8HoHLLaYSFSeaVmG0DBcxqnqXFFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: David Edmondson <david.edmondson@oracle.com>, Jiri Pirko
	<jiri@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com"
	<nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues
Thread-Index:
 AQHZUaV1hq+swD5r7EeFCHM9rP6wha7wxScAgAAFDACAAFmxgIAACLQAgAA3RYCAAKrygIAAXFnAgAARIACAAACcoIAABP0AgAABAECAAATHgIAAFyMwgAATAACAAAB50A==
Date: Thu, 9 Mar 2023 17:16:05 +0000
Message-ID:
 <PH0PR12MB54811FA8340D054A7B2C28ADDCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <m2wn3rxgv5.fsf@oracle.com>
 <PH0PR12MB548150700B50006F9F174104DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZAmLIc97Ud09YfGT@nanopsycho>
 <PH0PR12MB54817E2CEFF003E793C9B2F3DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <m2mt4mxbt5.fsf@oracle.com>
 <PH0PR12MB5481FD2D2365CC08A5CD1E64DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230309091904-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548138694D606CE68B9E0C3ADCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230309094240-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548118B78312924C00EF14D8DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230309121313-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230309121313-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB6825:EE_
x-ms-office365-filtering-correlation-id: 30123454-0060-4f63-81ac-08db20c1f7a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5k2HXvFVL5vDtYWYnkrkoHrK1Im4q9b3njHJ/oLZHZETwOw1zXcHJYrAuRuXstmhlgbz0qr4OYKo/p6z+o7nSP7FMBK0RqFJGl1q6ToYueVrxjtPIuWt18IBMLK54QT7jgz8bZg3xNKka5UR4hdTXg8Z0iz+DJjP+2i01OcachH4NZG3WG+SLwAwReBfJhotek/CNLvPAf35ebN2rUPX2aekWhl0svpkvjitRZArPhxsBcU7k1BK5sIuiFPSpPRRbH0dKJioKggOrPw1vB616qw67atKkAudGgOAD0bzAhPkaJN7cRad09COpN3w42U/BmpsM5mrDXtF5fhyR2cPa+XG0jV7EUaNuD8GN0CZb2IhTGviQ/rkzvsQ1or2ZbrMrqOOQxAJdb4koFgR0CptR33DrNTihpAsBT64T/gkzH5dXxv2ITsNAdfVTb1xb9+K8hhntHkPgVX8tDho6HAxPXcQtWyal6h6rBpKabstNw7nVkRHDLn7Ljoy5I+aUy9hojAwgzvi1Vw9G8jPFItHsSIl4ewew4dNuguZiTo+p23XfwtyEmJXrZrXhHGbizKqhNt9nYT2UVsjwIqBs+F5czbWXlG6aTtdbCikbC6awfxXoGwgfmfU20XFZNpVxa2qs6Kt5IIrRSPQvVT5TVs5/q3Lg8lXC4O5CY08/Gqp4lbtdEMkwuvz+2C6KJxGidlNPRDIGnfVAlQ3/PTqzsXPAA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199018)(478600001)(5660300002)(7416002)(9686003)(558084003)(186003)(55016003)(107886003)(83380400001)(6506007)(33656002)(86362001)(38070700005)(7696005)(71200400001)(2906002)(316002)(41300700001)(8676002)(64756008)(6916009)(66946007)(122000001)(66476007)(66556008)(66446008)(76116006)(4326008)(38100700002)(52536014)(54906003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VE97V0YAp3g0kmLloWsfhoSCszMt5FTBK+fhYgCUiv3bCzgg/L5ppYYQLirP?=
 =?us-ascii?Q?8Rv9MdKNsqoEZ81ohsoFIaU/eIkS2yHP0yO/GG0Fv3JmIKR37adY1SmZZyvo?=
 =?us-ascii?Q?q8emS/7b1LpxdUNDXxjIP4YKXlkCR7HRHAQtZ65jYNDiQr3RwhOzz872VCYp?=
 =?us-ascii?Q?c2gt8lpic62F4DVXUOXtouKMCTgaehIF3Rb3LcI70HzmJ8ooCMJdalzN8GNW?=
 =?us-ascii?Q?5dnsU8OOU3+UbdFn7XNAXliCU3daxfS0IRkYryI/kctUtibqlgjrfATgfrsx?=
 =?us-ascii?Q?zoNTPOc4EiLVQmZNTgvMxVOni5iAbFm4c5nMkxNNGRgpf/Hcd3veAGGWj7mv?=
 =?us-ascii?Q?3zeIAy9sosYrfE7JWcVXhoJSFsaKJBFSTWbO6fMls3T13R+HAHX7vkcbRcCR?=
 =?us-ascii?Q?5R52J8tGVSN4B6u3WELUH2DQVNGSlxw4worgpxVlm+5Q6aR2AldcyhnTQDql?=
 =?us-ascii?Q?Sb+oGI2sgQZotTxIdH882VX87YmAsNUBWfjK14eRhi3splEvAPu1aCwLmyeC?=
 =?us-ascii?Q?eRLbuMdumE2lvD/q8O43VVYlSb87BlVNxRanvkG4jIqSSk7ihJFeLCWtIYtv?=
 =?us-ascii?Q?+B2Kuw5T77GzsSh1Va5w5MDLK1qwt9Yh+QzAxjS4S4x8Jn58WrAajN6IqpHl?=
 =?us-ascii?Q?efq8wXAQRA4X8zUVgfMBQVhf8LH7EDl/kjWddWv3oAAtZQEVJfXURZxVgDEd?=
 =?us-ascii?Q?nRlzwpIL5Mtqqgh01OvgZIyQHSUoVF9ErI8VeNXb18MnvBrkOvX7Xhxng0rt?=
 =?us-ascii?Q?JQw36Nqll1ihRAHmiStBRq81/+B/KWVVbNazrwRdXGbUDCKmqeBxcmtDsbTg?=
 =?us-ascii?Q?nh0aoYv9F71F/WBNfnSlZbHof3uehfdb2CTZsAoJLaigcwac1JWGyOVsTApA?=
 =?us-ascii?Q?y5cFuG5LddFAnYijrsVGeR7vRq1nS2QwBqReurRaP8rRo1U9xR2ygwtfYuXl?=
 =?us-ascii?Q?phq4R1xKCDoBgraT7WG/XyX9P8O6c5GMqI3BaY9vvPCZP6iYllgSymyf8H6Y?=
 =?us-ascii?Q?X2/Qz8kxJd/WN9o379wwITJuzbOahBiW9x39XHZWevL0csgTjcqlDAySXUxq?=
 =?us-ascii?Q?1LhUGn578K5mrCIt0UjJdNr47mh6XVdA9OH/8ksFmmFb1uOinetEsCVounjX?=
 =?us-ascii?Q?WCtkFafyeYq8fYRSahCWIsXMLkW/G5lqWzDRxCt+cCkEvHE3YBgrW7WODs+9?=
 =?us-ascii?Q?MUaKVNEGYlUzmXIlYa6bNMU95xp+CKvmXf9jqzsrLU2QOelRYkWi603ke/gv?=
 =?us-ascii?Q?wo/O9zOBwL6X0fYdYHk9qCCZNlc8vw9twNBJDoNPFR5pp53ujbKh9m8Wwg3o?=
 =?us-ascii?Q?bN13J3pzS5d+KjgQZLs8IwA213HA8S0bbzLBhbkv4v/lxwhECS8WQMuVNdmH?=
 =?us-ascii?Q?JLVCE6cfJEX0d+oRhB0qwpILd03nxcdD/TT7PqtD+qPFJp+OOiK6UN2pWmtN?=
 =?us-ascii?Q?nJrg9x6zHYDVd+7W1cRapTba/9BuyFgfiiInkKJ71PZb1l1we+ueRFZ9rxC1?=
 =?us-ascii?Q?k9NH1dRm6cUYfLZJc5+dvqJittAORxrzAgJDe85+hycoOhBrrpM6xgMBn32O?=
 =?us-ascii?Q?i3sWBtBMZLgbLSINaq/4t1/DuPVlR6UfK+H1rwHEvsWTp2bRmjWDPQbk7WEM?=
 =?us-ascii?Q?eQUVgFwWOgoVObFpgL5VOY8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30123454-0060-4f63-81ac-08db20c1f7a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 17:16:05.8300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghH6HJVyh+k6EoBq/wtkPVe5NibdkFIjqmHwAPCaeRiTmby8EwpVe+w/0nOL/AQyaV0mUurIQUxlWMJDqMebWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio] [PATCH v10 04/10] admin: introduce
 virtio admin virtqueues



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, March 9, 2023 12:14 PM
>=20
> On Thu, Mar 09, 2023 at 04:53:59PM +0000, Parav Pandit wrote:
> > Keeping my inputs aside for moment, what do you propose for v11?
>=20
> Following SCSI and relying on driver to worry about ordering.
Got it. Thanks.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

