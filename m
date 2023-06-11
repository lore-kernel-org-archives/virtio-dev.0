Return-Path: <virtio-dev-return-12927-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB13EC7EE29
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 02:08:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2ACF02A88A
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 02:08:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1CE56986821
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 02:08:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0FFBA98680B; Sun, 11 Jun 2023 02:08:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EF12A986800;
	Sun, 11 Jun 2023 02:08:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMsRZ0PjVwK4fZSXiliDW03jI053dm2wOQvirdcMcBFY2P5EUu4EOTlKEW7xXF+WT7P8bnzCGwD33jgW6KtBS3o+kzSMuUYlpvWHqS2ViHCI4tjs30r3d7vrgqsE0rBDH++s3hSqLQuKLXU6PxQxKsrF15ryE4hRWF+7n3zsH+zOwZKtHtE10Xyd4b4pOcRjElgas77nBNi0/ndCeAswhiQct7olZDLRroctmTJz18lU7TrZayCfgVi/ZGUKV0thElWthUg9yrpNNAjvt665YDW5eI3opdAGlpXDAxerMf6mQvsQHY8WtnLz/rRJ/sTkRrEWoBOyOHFQEYOiYTbbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njIRkdKbXRzMMaGzQU0Xy5pMYjogQVsi0hj6BmdH6kk=;
 b=a6OZTJwjrDm5QXvm7qsWxMgzMywa82cMcRF7wWMiPcb08z/FkHE2tMZy6roq/EdbpB0FRcKeqGfiW5reTj20OaGsWy8s/UWaAm57Wv0qbAKlUBazonr57HwQwZi0szvlNRvzQ2ErO89yrnYwl8Lca+lSIY71kwvy+u7uk39DZeYqtNEIVbfLhekxcTLKVyAYllHipkpzDaEWxeY5YhSEQGr/ceuWe1v4gtLcpnMln8DL3uwFPqFA5dBjVKe63sHnl/zr6GzbSJ7fDADP2RQS77jixa0GQbrHp3Kp3JTnkDQUZRc+NKhCAOz1uo5/mM7XClyWRd3wrCI5vzfQ7gqg7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ
Thread-Index:
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4IAACZWAgAAiwLCAAGU9gIAAAqIggADn3oCAAPNNAIAACTvQgABBawCAAhKfIIAAwayAgAAF5ECAAAQjAIAAAcxggAACF4CAAAAyYIAAAZcAgAAARXCAADjCgIAAD1EAgACbcBCAAhV1gIAAG61A
Date: Sun, 11 Jun 2023 02:08:07 +0000
Message-ID:
 <DM8PR12MB54807B410DCF097D0DC969A1DC57A@DM8PR12MB5480.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481B197049376E7C4D0112EDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsPjwgx=atOC1ww+RnfJcrg7m2CmMXWQCCoreCwsWVpLg@mail.gmail.com>
 <PH0PR12MB54817C027CB2B7BB74BD35EDDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsGA4ZhOPn5OCTZEZkja2UrLpJ8DXH+d62Fp5rtdicseg@mail.gmail.com>
 <PH0PR12MB5481F1BE96B1CE71F4FBD2D8DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu+LDKUkg5ZZjcRsztrL1QGY2a6wto8r93Ddwc6L=a63w@mail.gmail.com>
 <PH0PR12MB5481175A9D915E3BF396AFFBDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsN=5DcMsZa5hHGKb9kCRUVA2CcwZ4uif-E0HKaXiJ-fA@mail.gmail.com>
 <20230609031923-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CE9205B222B57680AE4DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230610202143-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230610202143-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5480:EE_|SA1PR12MB7102:EE_
x-ms-office365-filtering-correlation-id: 2c932747-c6af-4d0d-4b4b-08db6a20b31e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uViKTOmVTQ1iw6tB7XV4Hs0atckd1TLfdqrsM1kMmzxo+pLXERx/VVCbkRCRx6T3DQC4/UwFdQkk52nw36aYlSKrXBxvxf22CFYxS0Jy9p5iHZXVviTUVBye4tQh8skYvpFKSYfytP9j2jtRtX+ComrzMxSPFOQeerHCyUuqw7Ifn86T0YtHIVC4rV1wfQWQc2ltzr4SMwzBgBxrZ+8Et8EZrr91zmxNrC8SxMkH+BNqQBx364AD5/L+EJO0QgA0sk+E9CzY89uBkrjh1rdzz1b2apz1fVxCtpTTXLePiDf0S5PqxhZwLwDvcZVqhxmxs/10j5uDUgP6KQq8RdU3ogo+efEVZzL10kE0vSOQRw9AM+rk/jrn7JuYs2mK74YDZqj8unLZKs0mMt9jKjeqAuAnRmJMcjakqA6q0xWi7JE+jA1LUOkQrjUrcsQT7M8tiBpF94HP3KIBbDyaLpCjAYyxlJJoBgbTqAlPhXBItJB5tFAjN9QsNbfbjx6p/VtRX7okIy1PI4+1aFi1+NahVMiQ6vaI7J3DiAM/v+Q67BARTsrHpigq1G7f3GWiRANGTD1sOxMudqe9FipBLzEBVypO2I4UL/wDrhP7aPBrZZY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199021)(76116006)(8676002)(66946007)(5660300002)(52536014)(66446008)(66476007)(6916009)(4326008)(64756008)(66556008)(71200400001)(54906003)(478600001)(7696005)(41300700001)(316002)(8936002)(38100700002)(122000001)(55016003)(9686003)(6506007)(38070700005)(2906002)(107886003)(83380400001)(86362001)(186003)(4744005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wdEGF6RO5qvwCT8EI8texuLfViiGKLYl+k4hCTOuHgYePAVn5zVJRoDBq1Hm?=
 =?us-ascii?Q?cEKsyyXjI6mYX/xS6IOnvpy5VfCFucHp0j/FRxPhjSK3UXgEFj1n53g5/OXf?=
 =?us-ascii?Q?Ts7jfQsjafFJZ70YDlS0LizYTu2xJ7/sgmVjEHnddKpJ3Eu4+o+4/q0w6ERC?=
 =?us-ascii?Q?yDHGSs2/hvlE3s2EMMKs2Ms56ZDscwRT2QmJsTblpoHZK00iYCt2bfHTbMsP?=
 =?us-ascii?Q?0DnwYINkV/G4s5NwMq0SJUBpS856tDcdB34apEB7ZM9bybgh0QLoZeL28XfA?=
 =?us-ascii?Q?Lp001OdSNB7ek5cEyhdDv2tiWjnTHvnOqjUsUEstwISeIfNhSqYn5mdNkIZX?=
 =?us-ascii?Q?348Pt8sD93Dr7w/h2E9Vg67tvf0qXgQySaUCZSg4E+7LDB5mSW3mNCDp3ibo?=
 =?us-ascii?Q?lelp47Eyx0RvSERTjLqcQXRMDfDriIddpYW4HwbvEmB1yoB10NGiXqyUQRxc?=
 =?us-ascii?Q?sS5l4sUPxsVWQ+28Mm1S2lx/ksgajgoQggEQDyaSHSjbAkCKFlDhlUgLtPp6?=
 =?us-ascii?Q?Kly/gEipy4GQwtg0dAWP1iWCOdbZ/N2OQ6BOIdQA2G/QJcImZWFn4kZvDfGB?=
 =?us-ascii?Q?mbVC7xn5gUNJG4tzURK7gANx06WR7UL5HlZLL/XDZiX3gdKmGD++nZDA3i/u?=
 =?us-ascii?Q?IhkC0sx/eBUxEpkUaO5MCCQ5O9aA17Xwl5dL/I27RNyYfGs5OEK+Hf5yLJOn?=
 =?us-ascii?Q?lUnQeJRPbxpC3BAjPk5ywbui5rlDOtOhW8wl0R4NkiHZLdaIaZPhDHbv0UPx?=
 =?us-ascii?Q?w6vikF97qWzoxvTxaMnELX3y0gvRSrfWHox2bADti2wFdVW2pbGQVDOuO6yz?=
 =?us-ascii?Q?2whaI/RnKTj3jqhqRe4tyPpmf3rcLw37zTpysktRYxoMIQXCnVzT4B73SSGs?=
 =?us-ascii?Q?cdhkG37xvP01HlAJ0QG1pUwGs1r5O5hNZvOA77PIuQqsQrKt9zjEZKjihaAZ?=
 =?us-ascii?Q?7Xwe77SjeUCLSXipvAt15Sgq0VlYqOBKjiCAJlQHk5fmilFVj9UrWRKruxMR?=
 =?us-ascii?Q?S57CmRQgjRxb6vY5WEqb7+DzXLzf9m1K0NkWgdV5G5z06LgdJNGUFzYsXHwj?=
 =?us-ascii?Q?AR8fQdnUoVaqUxPO2ebLKVbeNh1stVGTt8/0JjNmI1Wj2yEbZfm1v7fHIpve?=
 =?us-ascii?Q?H2mFALA9/PFH9aFwUlrhfKOBBvSNY3vjLwUJY9YlbUTp3ldzyXoJTVr9+iqc?=
 =?us-ascii?Q?neHtT7W/ND+b5eQPlqBYpXCpf/Jk0bQPg9bDTFbS+hhb4n+2UmOtjxsVdF5o?=
 =?us-ascii?Q?xqy3pn3A3SnhZ+R6gEAYbtoS2cYsRi7nSX4j+hwLKgc98O/7arIUG7X38ZKd?=
 =?us-ascii?Q?pgbWoQ09mUC8/D4/fF3nzcpQM3sBprmX5zVkdvlJ/GQ8bVYPjXreX7vrj0/o?=
 =?us-ascii?Q?IPcVP0VdnHBSEzCvhd70o6TCzeQaWyokuQPAf4wxyYiOhhNDVbYw04dBiwxW?=
 =?us-ascii?Q?VLIMOsGF60JkM8AkitV2KtmFJTXJTJpImNUWSkljGQQxwsnDclPVGoFK3pIa?=
 =?us-ascii?Q?0dZKwgXnsPFS1z+TT1M7SbobgL++CLGW9cGSR0aP3xzTKdODkpAi/xZceiII?=
 =?us-ascii?Q?FU+TdZ+lpys0zwmreDKaD5ieBs9khitgA5xnYa1+84p3hDXuojy0mUWvCFoU?=
 =?us-ascii?Q?z3TwascCgLuxwzKjfkP/f5I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c932747-c6af-4d0d-4b4b-08db6a20b31e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2023 02:08:07.9285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eXs/i1S0epA2NMtLY3uEVuvVR5j5EF74ixqsxE0uBhfu+8G/hdpNYiEjZq9K1EelHBrOBS9Vt4ufUNjVfquHnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Saturday, June 10, 2023 8:27 PM
>=20
> Interesting this actually violates a spec recommendation:
>=20
> 	If a device has successfully negotiated a set of features
> 	at least once (by accepting the FEATURES_OK \field{device
> 	status} bit during device initialization), then it SHOULD
> 	NOT fail re-negotiation of the same set of features after
> 	a device or system reset.  Failure to do so would interfere
> 	with resuming from suspend and error recovery.
>
This is how we have seen mlx5 device and it has evolved now to break free s=
uch limitation.

> Nothing is tied to admin queue here btw - it's using admin commands.

Sure.  It is admin command, presently using AQ. May be some other transport=
 tomorrow.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

