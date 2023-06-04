Return-Path: <virtio-dev-return-12842-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6F0C77B73
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 13:42:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4002523D69
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 13:42:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 30761986495
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 13:42:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 237149862E3; Sun,  4 Jun 2023 13:42:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0F02E9862D0;
	Sun,  4 Jun 2023 13:42:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRzjx0TXSkV189diCoLOANWzRNcksBje6y3baJQJ4vvF0t97oDEvfaQJv8FNl10k1h+3ZYQAnyEK+SV3MfsD3SH/91DV/Pu2mskcLgiczvcrNV/GtteffEh0/89zIqQwV15i0fSjshAfYR9yBvSh3n3NCyywZLnvuZTz8Wc7dL9fjSVqawq8qJEt4VS4XHWbgftDhm9s1UUjB7UVRJHMhfu1HQlqhgneo2iNCAvFIj14+3s19hOeDo8wICmDHgxh47K2dNLdaRuDsoVRxDcKsJj1sVFShRah9y6XgNMQB5x2XxpM8c5Cpmbn5oafObs6FVfgsAWDgNb50gsSKl8eRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnynYAF/gQ8tw36khI01hizE/W1CKIZxaFlNFEfH3EM=;
 b=EBHGdWsK7F/TR+szwcXpCB1PVSWyeymNeyBs8sBO2vhcxwEYaLDh4vwNO40PltrAciuGoW2XHKhSRh0D4MNDXofALp/6UnBoOo4ZQpbFCGzhVQHYo0fL/0mrue0EzI6foKBxBFNMiID5CBaXXEe+dRXg2iHnOo26rqVOGZcsx0IwtTtS/XlIJw97wQF08xlml3AWbk+HkCCK83RUQwvY0pub+XX7RY0UzoJ5PtZTx6uv/PgV925+yZ0ebxDMbmUcNH/GCdURoH/f0y3TmFyVia49FYSI74pEYPlx8jjCRNZn/10Tw269Y4Vq0tucHXZwdQL/OOvbxBmqXdgGLPzBGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v3 0/3] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index: AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkA=
Date: Sun, 4 Jun 2023 13:41:54 +0000
Message-ID:
 <PH0PR12MB54815C9677C9E1F3EDE032A9DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230602203604.627661-1-parav@nvidia.com>
 <20230604092441-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230604092441-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA0PR12MB4590:EE_
x-ms-office365-filtering-correlation-id: 9a3df6bd-4472-43e8-e9c9-08db650175be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Rcmhq+x85GH0NAhEtc5PHPcA0spnOy66KETHXlLEQSOJhvcixaojp77WDk7zTpW5DsvQPkzbzQcT8Z91fCszR7WBOmoNlAdBvK9KGTMTyvOldY/qGfBdqKI3VkLSDJ1o193pAiwxx9TCM5lBNAvuGsP8XkJo4ZUZxTCjTiLoBgkV5jTQZyaNtLc0mZjs77gJHnHFGozdVdNv4dsP4tTycmlAIELCjLZXBl1vtqHSldw6WHYkwJVkuOGIWdNE0aXGcqq98bTL0TvyjSdP3lrwiT/KCScLu7j7Q1ExYJ7b6xXYWGeQD+IPZqTe6IjdZXN8+N7IkJ6i/TANMmb+vVZ1gvtkB7KEnQg9J901rI4cmkXY5tRpcV38yNbveUhS2a5ARKQ1gy+xzkLC5j1sQoU1hcfeVzluFUvEaJ5aOr2JZQfrOz1jJarDfVqoNLjS6ugk+B16lY3rrGoMd6PRAZqm6wPw3CNbKYlWPnpCF3xutwPnk3bDKsQXAFK8X9H05SjGSqnQGZPvglQlj30KK1mSWYHu3VxdSFYKFyjvz4ZM2QzlySq14topL1UDMs48uRjTWw3tG8GoF6vqpDSRTSK/rZUikNDdCbN8YY5QAFxPcU3PFfmsNIiMaG4RqKQNHE/L
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199021)(54906003)(71200400001)(478600001)(52536014)(8936002)(8676002)(5660300002)(38070700005)(2906002)(33656002)(86362001)(4326008)(122000001)(6916009)(64756008)(66446008)(66476007)(66556008)(316002)(66946007)(76116006)(55016003)(38100700002)(41300700001)(26005)(107886003)(186003)(7696005)(9686003)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHlYTFltTUdaQ283SGtTeEFITGNCL2l0a2RTM1UwV0dHOWcwd0JFdHdLYVgr?=
 =?utf-8?B?Y0tWN3YzdU5ZUW93anlRV0szM0YraDV0SnN5R1ExZllNQkhDVzk1Y0hkZVQ5?=
 =?utf-8?B?NUE1Vm1ESlRKZm9LS3hrd01taHI2dTZFTWRJTCt0eHJyNXdpamxqR01sOEVD?=
 =?utf-8?B?T1Q1dXp2N2pNTVZTMHNFNzNRMys5WG1oNE1FNm5MRjNtK3l3dmptdVVPZmJt?=
 =?utf-8?B?bnkyUk5aYkNtQmJmY2dkZ1pObWpFbU52YUluT2NQTlZEbUJyNkpjTzFOYm5C?=
 =?utf-8?B?NWJXQ1A4N01VdnVtRldKSzhRaEZmS1h1ZTJ5SnV6VXlZL1M2RlZucURLQzRN?=
 =?utf-8?B?bFkyUVNqQjVXOE11RFIvMnVsSzYvckZETHpnL0l0S2JGNWtYVm9mZ3hkcHdo?=
 =?utf-8?B?dUpPd3NzdFRrUTVvblRrMjBFV3c5elVVNXhMNjBWSnRZaHlNZlZURG1EeUd6?=
 =?utf-8?B?L1N3bDRqUFliM1h0VFd1T1ptclpaeUUzSE9PUVdmZGcrVExmNVJZUGdBcWVB?=
 =?utf-8?B?WVBlOU9kbDlnQWRLV1lwRC9oWmU4SE9oU3ZXUnp2bDNIc05tMFR1bFpEY1da?=
 =?utf-8?B?SENVUUVPUkRLZ3JVRHR4NkNoSmNlWWQ4OS93VFIrZW0raXNWRVNqUzJZSzZC?=
 =?utf-8?B?UWV5TzJacWdNMTdLRGRad1c1ZVZOMElMNU91ZjUzK2JVRkFKU2dUUFB5dVhX?=
 =?utf-8?B?RzVyOWcwQ29vY0FjY3BQc2NXMDBIblhmS1BrRSs1NjU2OFFXREl2L1BCOFNW?=
 =?utf-8?B?V01MSlN4V0YxK2tPSmRVSkxuMENwZnU3Tzh4bkt4TVdMVmNnUEx5KzdhcUh2?=
 =?utf-8?B?Q0I4MmkvdFc0Zlg1STRkRWcxU0hUU0ZoNWQzTXVRaTZLMTcwSkZOR1ExYTc4?=
 =?utf-8?B?dFB0d2lrUjZFTkp1dmtpS0V2MU52MUUxVXRwVEdkWmoxeHNHdm9GelN4M2FS?=
 =?utf-8?B?T3UvQVV2OFZRYmJoUzdTbGpKeDhoVHNUY01Xc25xd25yNDlZREN6T2NoQmhW?=
 =?utf-8?B?VzI2UHhGbStHclBWVzkrVS9aNkd6aFVjUXBRanI3bkl4UWs2REs5TkJJVitq?=
 =?utf-8?B?Nms0c0tEdExIT1JHblB4NFYydTZaRzdhVWtyT1JEeHpybGZrMUpEM2pWWEhH?=
 =?utf-8?B?dVF1M3RpNFR6aXZVcXdRalc5Z3ZHakV0TmJrUERTNEdmZWE2WGM4YlJCcmZw?=
 =?utf-8?B?NWc0Q0JnTVNJWHNDYStXUXpuRHZxZTZOay9rVTlqbkw5RmdFTFUyTXk2cFJ1?=
 =?utf-8?B?cEF6Z1didER4amZ6c3JrV3AzOWsyVXhYWlQ3K01BcDE1VnRhVEVRT1k1cXNP?=
 =?utf-8?B?NVd1MWgyMUFzNFdXbFl6dy90MlFCMXJBNW8rQXRWNy9GcGltdUZsKzMvWnVK?=
 =?utf-8?B?SWF0VHdUQjZaSDQxVFFkQVRGMmlpYkFyUDJiSUpLY21GcFRmbEdFM1RCMFJl?=
 =?utf-8?B?ZVc5bXRvdFo1c3dKbUFmSFFPeGp1UFhaeTFXRjVNNFpHSVZaRmNzY2thdkYy?=
 =?utf-8?B?R3N3NjJzY014RVhFSmpDa0dmdi8rWXBheno4S2V3UENFUENtRVp2S203U3V6?=
 =?utf-8?B?UGxGOE9BT3hPMDRyMHRYVGJZTVEyMWdqUDVxaS8xbW9WM0ZlS2tlL1dKNHpU?=
 =?utf-8?B?ZUs0dk5POXBoNTR0TmVwV2p1MldCRzd3eVBiSGVySkI5YlltZGNuLzJwdXZR?=
 =?utf-8?B?cXNseXk4NUpGb1NRWFJIM3BDS3JoejExdUtXdVkxS1E1dXc3eVhyOU03Um9o?=
 =?utf-8?B?OWFOUFQwQUVnZzF3VEgzdkRQRkR3d3RuODIrK1ljdlZDOGpxWWVxaWVUNjVp?=
 =?utf-8?B?MFN5MXdwNmVuZXFOMlVmU1Zuc29PODZodlI2NW5uZE5yQ2pSUDl2ekNEMS9Q?=
 =?utf-8?B?M3AzQkxlSWc5eG1WZ0NKSkNIQ2wyVjdLZUVZTjBVb2pSbi8rczlEN21RUEMr?=
 =?utf-8?B?Zlk0VWtTclBoTWRrR1greHB5OEFNQmJocWY2dk1aTVhyR1hBNjNodExNNU5o?=
 =?utf-8?B?cmdZWjVoOUx2OXQ4aFNMRVdkT3lTOFlUWU8xa1I1VU5EMFRkeDZpVDJGZTZ0?=
 =?utf-8?B?Yk5SbVg5YlFQRFpLRmNWeWJTOUNaQXd2Y08zVFNlaTErS3kxS2V1Qmp3SkJF?=
 =?utf-8?Q?u7Lc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3df6bd-4472-43e8-e9c9-08db650175be
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2023 13:41:54.7724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zx5llaNMSoyasmdBKnESr4Obh5dus7+uRQouTpMMpJlcnajW7PjK61A92UzS5L9jbBtqHsdkCyLNjA5uDtBzTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4590
Subject: [virtio-dev] RE: [PATCH v3 0/3] transport-pci: Introduce legacy registers access
 using AQ

DQoNCj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDog
U3VuZGF5LCBKdW5lIDQsIDIwMjMgOTozNCBBTQ0KPiANCj4gT24gRnJpLCBKdW4gMDIsIDIwMjMg
YXQgMTE6MzY6MDFQTSArMDMwMCwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+IFRoaXMgc2hvcnQg
c2VyaWVzIGludHJvZHVjZXMgbGVnYWN5IHJlZ2lzdGVycyBhY2Nlc3MgY29tbWFuZHMgZm9yIHRo
ZQ0KPiA+IG93bmVyIGdyb3VwIG1lbWJlciBQQ0kgUEYgdG8gYWNjZXNzIHRoZSBsZWdhY3kgcmVn
aXN0ZXJzIG9mIHRoZSBtZW1iZXIgVkZzLg0KPiANCj4gTm90ZSB0aGF0IHNvbWUgd29yayB3aWxs
IGJlIG5lZWRlZCBoZXJlIHRvIGZpeCB1cCBncmFtbWFyIGFuZCBzcGVsbGluZw0KPiBtaXN0YWtl
cy4NCj4NCkkgYWxyZWFkeSB2ZXJpZmllZCB1c2luZyBjb2Rlc3BlbGwgYnV0IEkgZ3Vlc3MgaXQg
bWlzc2VkIGZldy4NCklmIHlvdSBoYXZlIHNwZWNpZmljIGFscmVhZHkgaWRlbnRpZmllZCwgbGV0
IG1lIGtub3cuDQpJZiBub3QgSSB3aWxsIHJ1biBhIGRpZmZlcmVudCBjaGVja2VyLg0KIA0KPiA+
IElmIGluIGZ1dHVyZSBhbnkgU0lPViBkZXZpY2VzIHRvIHN1cHBvcnQgbGVnYWN5IHJlZ2lzdGVy
cywgdGhleSBjYW4gYmUNCj4gPiBlYXNpbHkgc3VwcG9ydGVkIHVzaW5nIHNhbWUgY29tbWFuZHMg
YnkgdXNpbmcgdGhlIGdyb3VwIG1lbWJlcg0KPiA+IGlkZW50aWZpZXJzIG9mIHRoZSBmdXR1cmUg
U0lPViBkZXZpY2VzLg0KPiANCj4gWWVzLCB3aXRoIHRoZSBleGNlcHRpb24gb2YNCj4gVklSVElP
X0FETUlOX0NNRF9MUV9OT1RJRllfUVVFUlkgLSBjdXJyZW50bHkgcmVmZXJzIHRvIFZGIEJBUiwN
Cj4gc3ViZnVuY3Rpb25zIGRvIG5vdCBoYXZlIGl0Lg0KQSBzdWJmdW5jdGlvbiB3aWxsIGFsc28g
aGF2ZSBpdHMgb3duIEJBUiBjYXJ2ZWQgb3V0IGZyb20gdGhlIFBGIEJBUi4NCkEgc3ViZnVuY3Rp
b24gZGVmaW5pdGlvbiB3aWxsIGJlIGFzIGNvbnRhaW5zIGFzIHBvc3NpYmxlLg0KDQo+IENhbiB3
ZSBmaW5kIGEgd2F5IHRvIGhhdmUgaXQgaW4gdGhlIFBGIEJBUiBpbnN0ZWFkPw0KQXQgc3ViZnV0
aW9uIGxldmVsIGFsc28gaXQgd2lsbCBiZSBhIEJBUiBudW1iZXIsIHdoaWNoIHdpbGwgbWFwIHRv
IHRoZSBQRiBCQVIuDQoNCj4gRS5nLiB0aGUgbm90aWZpY2F0aW9uIGNhbiBpbmNsdWRlIFZGIyAr
IFZRIz8NCj4gQXQgbGVhc3QgYXMgYW4gb3B0aW9uPw0KTm8uIHdlIGRpc2N1c3NlZCB0aGlzIGJl
Zm9yZSB0byBoYXZlIGVhY2ggZGV2aWNlIG9uIGl0cyBvd24gQkFSLiBIZW5jZSBubyBWRiMgaW4g
dGhlIGRvb3JiZWxsLg0KDQo+IElmIG5vdCBjYW4geW91IGFkZCBzb21lIGluZm8gZXhwbGFpbmlu
ZyB3aHkgbm90Pw0KWWVzLCBHb29kIHBvaW50Lg0KSSB3aWxsIGFkZCB0aGUgY29tbWl0IGxvZyBl
eHBsYW5hdGlvbiB0aGF0IGV2ZXJ5IFZGIGhhcyBpdHMgb3duIEJBUiBoZW5jZSBpdCBkb2VzIG5v
dCB1c2UgUEYgQkFSLg0K

